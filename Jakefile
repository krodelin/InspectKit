/*
 * Jakefile
 * InspectKit
 *
 * Created by Udo Schneider on May 29, 2013.
 *
 * Copyright 2013, Krodelin Software Solutions. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

require("./common.jake")

//===========================================================
//  DO NOT REMOVE
//===========================================================

var SYS = require("system"),
    ENV = SYS.env,
    FILE = require("file"),
    OS = require("os");


//===========================================================
//  USER CONFIGURABLE VARIABLES
//===========================================================

/*
    The directory in which the project will be built. By default
    it is built in $CAPP_BUILD if that is defined, otherwise
    in a "Build" directory within the project directory.
*/
var buildDir = ENV["BUILD_PATH"] || ENV["CAPP_BUILD"] || "Build";

/*
    The list of directories containing Objective-J source
    that should be compiled by jake. The main framework
    directory is always checked for Objective-J source,
    you only need to edit this if you have source in
    subdirectories. Do NOT include a leading ortrailing slash
    in the directory name.

    Example:

    var sourceDirs = [
            "Core",
            "Modules",
            "Modules/Foo",
            "Modules/Bar"
        ];
*/
var sourceDirs = [
    ];


 //===========================================================
 //  AUTOMATICALLY GENERATED
 //
 //  Do not edit! (unless you know what you are doing)
 //===========================================================

var stream = require("narwhal/term").stream,
    JAKE = require("jake"),
    task = JAKE.task,
    CLEAN = require("jake/clean").CLEAN,
    CLOBBER = require("jake/clean").CLOBBER,
    FileList = JAKE.FileList,
    filedir = JAKE.filedir,
    framework = require("cappuccino/jake").framework,
    browserEnvironment = require("objective-j/jake/environment").Browser,
    configuration = ENV["CONFIG"] || ENV["CONFIGURATION"] || ENV["c"] || "Debug",
    productName = "InspectKit",
    buildPath = FILE.canonical(FILE.join(buildDir, productName + ".build")),
    packageFrameworksPath = FILE.join(SYS.prefix, "packages", "cappuccino", "Frameworks"),
    debugPackagePath = FILE.join(packageFrameworksPath, "Debug", productName);
    releasePackagePath = FILE.join(packageFrameworksPath, productName);

var frameworkTask = framework (productName, function(frameworkTask)
{
    frameworkTask.setBuildIntermediatesPath(FILE.join(buildPath, configuration));
    frameworkTask.setBuildPath(FILE.join(buildDir, configuration));

    frameworkTask.setProductName(productName);
    frameworkTask.setIdentifier("com.krodelin.InspectKit");
    frameworkTask.setVersion("1.0");
    frameworkTask.setAuthor("Krodelin Software Solutions");
    frameworkTask.setEmail("info@krodelin.com");
    frameworkTask.setSummary("InspectKit");

    var includes = sourceDirs.map(function(dir) { return dir + "/*.j"; }),
        fileList = new FileList();

    includes.unshift("*.j");
    fileList.include(includes);
    frameworkTask.setSources(fileList);
    frameworkTask.setResources(new FileList("Resources/**/*"));
    frameworkTask.setFlattensSources(true);
    frameworkTask.setInfoPlistPath("Info.plist");
    frameworkTask.setLicense(BundleTask.License.LGPL_v2_1);
    //frameworkTask.setEnvironments([browserEnvironment]);

    if (configuration === "Debug")
        frameworkTask.setCompilerFlags("-DDEBUG -g");
    else
        frameworkTask.setCompilerFlags("-O");
});

task ("debug", function()
{
    ENV["CONFIGURATION"] = "Debug";
    JAKE.subjake(["."], "build", ENV);
});

task ("release", function()
{
    ENV["CONFIGURATION"] = "Release";
    JAKE.subjake(["."], "build", ENV);
});

task ("default", ["release"]);

var frameworkCJS = FILE.join(buildDir, configuration, "CommonJS", "cappuccino", "Frameworks", productName);

filedir (frameworkCJS, [productName], function()
{
    if (FILE.exists(frameworkCJS))
        FILE.rmtree(frameworkCJS);

    FILE.copyTree(frameworkTask.buildProductPath(), frameworkCJS);
});

task ("build", [productName, frameworkCJS]);

task ("all", ["debug", "release", "documentation"]);

task ("install", ["debug", "release"], function()
{
    install("copy");
});

task ("install-symlinks", ["debug", "release"], function()
{
    install("symlink");
});

task ("help", function()
{
    var app = JAKE.application().name();

    colorPrint("--------------------------------------------------------------------------", "bold+green");
    colorPrint("InspectKit - Framework", "bold+green");
    colorPrint("--------------------------------------------------------------------------", "bold+green");

    describeTask(app, "debug", "Builds a debug version at " + FILE.join(buildDir, "Debug", productName));
    describeTask(app, "release", "Builds a release version at " + FILE.join(buildDir, "Release", productName));
    describeTask(app, "all", "Builds a debug and release version");
    describeTask(app, "install", "Builds a debug and release version, then installs in " + packageFrameworksPath);
    describeTask(app, "install-symlinks", "Builds a debug and release version, then symlinks the built versions into " + packageFrameworksPath);
    describeTask(app, "clean", "Removes the intermediate build files");
    describeTask(app, "clobber", "Removes the intermediate build files and the installed frameworks");

    colorPrint("--------------------------------------------------------------------------", "bold+green");
});

task ("documentation", function()
{
    // try to find a doxygen executable in the PATH;
    var doxygen = executableExists("doxygen");

    // If the Doxygen application is installed on Mac OS X, use that
    if (!doxygen && executableExists("mdfind"))
    {
        var p = OS.popen(["mdfind", "kMDItemContentType == 'com.apple.application-bundle' && kMDItemCFBundleIdentifier == 'org.doxygen'"]);
        if (p.wait() === 0)
        {
            var doxygenApps = p.stdout.read().split("\n");
            if (doxygenApps[0])
                doxygen = FILE.join(doxygenApps[0], "Contents/Resources/doxygen");
        }
    }

    if (doxygen && FILE.exists(doxygen))
    {
        stream.print("\0green(Using " + doxygen + " for doxygen binary.\0)");

        var documentationDir = FILE.join("Doxygen");

        if (OS.system([FILE.join(documentationDir, "make_headers.sh")]))
            OS.exit(1); //rake abort if ($? != 0)

        if (!OS.system([doxygen, FILE.join(documentationDir, "StropheCappuccino.doxygen")]))
        {
            rm_rf($DOCUMENTATION_BUILD);
            // mv("debug.txt", FILE.join("Documentation", "debug.txt"));
            mv("Documentation", $DOCUMENTATION_BUILD);
        }

        OS.system(["ruby", FILE.join(documentationDir, "cleanup_headers")]);
    }
    else
        stream.print("\0yellow(Doxygen not installed, skipping documentation generation.\0)");
});

task ("docs", ["documentation"]);


CLEAN.include(buildPath);
CLOBBER.include(FILE.join(buildDir, "Debug", productName))
       .include(FILE.join(buildDir, "Release", productName))
       .include(debugPackagePath)
       .include(releasePackagePath);

var install = function(action)
{
    var packageFrameworksPath = FILE.join(SYS.prefix, "packages", "cappuccino", "Frameworks");

    ["Release", "Debug"].forEach(function(aConfig)
    {
        colorPrint((action === "symlink" ? "Symlinking " : "Copying ") + aConfig + "...", "cyan");

        if (aConfig === "Debug")
            packageFrameworksPath = FILE.join(packageFrameworksPath, aConfig);

        if (!FILE.isDirectory(packageFrameworksPath))
            sudo(["mkdir", "-p", packageFrameworksPath]);

        var buildPath = FILE.absolute(FILE.join(buildDir, aConfig, productName)),
            targetPath = FILE.join(packageFrameworksPath, productName);

        if (action === "symlink")
            directoryOp(["ln", "-sf", buildPath, targetPath]);
        else
            directoryOp(["cp", "-rf", buildPath, targetPath]);
    });
};

var directoryOp = function(cmd)
{
    var targetPath = cmd[cmd.length - 1];

    if (FILE.isDirectory(targetPath))
        sudo(["rm", "-rf", targetPath]);

    sudo(cmd);
};

var sudo = function(cmd)
{
    if (OS.system(cmd))
        OS.system(["sudo"].concat(cmd));
};

var describeTask = function(application, task, description)
{
    colorPrint("\n" + application + " " + task, "violet");
    description.split("\n").forEach(function(line)
    {
        stream.print("   " + line);
    });
};

var colorPrint = function(message, color)
{
    var matches = color.match(/(bold(?: |\+))?(.+)/);

    if (!matches)
        return;

    message = "\0" + matches[2] + "(" + message + "\0)";

    if (matches[1])
        message = "\0bold(" + message + "\0)";

    stream.print(message);
};
