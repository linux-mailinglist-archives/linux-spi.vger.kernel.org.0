Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DE42E1B0
	for <lists+linux-spi@lfdr.de>; Thu, 14 Oct 2021 20:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJNS41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Oct 2021 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhJNS40 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Oct 2021 14:56:26 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C304EC061570
        for <linux-spi@vger.kernel.org>; Thu, 14 Oct 2021 11:54:21 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id e10so8664346uab.3
        for <linux-spi@vger.kernel.org>; Thu, 14 Oct 2021 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKHCFm948WtIFO9qw+GGuKUrAJivRhq00DHQ7qnJVjk=;
        b=fgnpRd6OfQgfHMq4ohqOGPeSvsSvoFWgvlaSSL/paEL7InAdCmgZ7NP+GOp7rhVt+p
         cnq53zu1gKXqLTD9lDm8aQkeB0hxZ1R6kU2IM2DWkyCNbfXQ0BH5SJu5FpSIclqk/9Aq
         1zo34WGPCCjtLMfEejBr/8YWTGCScckTYKIeSNQKkggwzCeJ7yyX60A94F+iK4o2lMgd
         f+EZhJCoXx+YIbtk+hpY6G5+PRnMa4oTSBhwqXsdxPjSxXowtRnyHd3MyyF2AE+NERDP
         H+OQCPfmTFOksXUmbwcXg4puv6Js2N2aBCVVGuGQveYX3oc0Bg8wWj397DwjZaTiuo+Z
         VESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKHCFm948WtIFO9qw+GGuKUrAJivRhq00DHQ7qnJVjk=;
        b=1/N/sELKUNN/w+jEbCH58Mrfs6ajuQHW/KJJb6b+9PMW4pMUtZHFDNkwHQDZ0tMueS
         unmWLAqN1isyX5lJM79B4a6krScU2hbi58OdrkizSwo235aIIeSO44tdqUMhDMg9WBcH
         fBOO9uBzctIO0peTdGbEK57KMB8lx/QcBdaP4Iavh+fcwMgTRUoQvEkUoSTueIao2q2C
         StXVYmoxjdxNS2xnYW3WNjDDWIaVe5A0h/bV2ziFSia+J91GOy/rgf0Hh0wrDEhoOaJf
         1SS6VmdFM9FfCXDM/GSTtyjwfTVle+fW+1b56AtsZPTZ9z4DjYWixtfAR0h+dMHcsIJ0
         peYw==
X-Gm-Message-State: AOAM533zF0V+PCIeZK3uffpZTOxR1SOBz37LWp/dlt6KT2Bcr2XK2wux
        pIfJe6dGacdfYxJXkLN62ORmi0tGI6HsVdKXPwyfuQ==
X-Google-Smtp-Source: ABdhPJyvXh03CxCEy+LdwAXkQlUKABzoDdH9ppCwO0gJTK6hoU2+XCA13Y+kVzH4eWro7VAOLT1nAfcg/Okb6KHptmI=
X-Received: by 2002:a05:6102:54aa:: with SMTP id bk42mr5784202vsb.61.1634237660914;
 Thu, 14 Oct 2021 11:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211013114432.31352-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20211013114432.31352-1-mika.westerberg@linux.intel.com>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Thu, 14 Oct 2021 15:54:09 -0300
Message-ID: <CAArk9MOscFASjen3=6VmUwkMZooPJ3RqrenNiQ4QVmp_rEoL2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi all,

On Wed, Oct 13, 2021 at 8:44 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi all,
>
> Based on discussion on the patch I sent some time ago here:
>
>   http://lists.infradead.org/pipermail/linux-mtd/2021-June/086867.html
>
> it turns out that the preferred way to deal with the SPI flash controller
> drivers is through SPI MEM which is part of Linux SPI subsystem.
>
> This series does that for the intel-spi driver. This also renames the
> driver to follow the convention used in the SPI subsystem. The first patch
> improves the write protection handling to be slightly more safer. The
> following two patches do the conversion itself. Note the Intel SPI flash
> controller only allows commands such as read, write and so on and it
> internally uses whatever addressing etc. it figured from the SFDP on the
> flash device.
>
> Previous versions of the patch series can be found here:
>
>   v2: https://lore.kernel.org/linux-mtd/20211007112132.30934-1-mika.westerberg@linux.intel.com/
>   v1: https://lore.kernel.org/linux-mtd/20210930100719.2176-1-mika.westerberg@linux.intel.com/
>
> Changes from v2:
>
>   * Added tag from Andy
>   * Check buswidth in intel_spi_supports_mem_op() and return false if octal
>     mode is asked. The Intel controllers support buswidths 1-4 but this is
>     not exposed to software. It figures this itself through SFDP tables.
>   * In case of software sequencer, support same opcodes than we support with
>     the hardware sequencer if found in the opcodes table.
>
> Changes from v1:
>
>   * Arrange dependencies in Kconfig entries the same way in both glue
>     drivers.
>   * Added empty lines between different subsystem includes.
>   * dev_err() to single line
>   * Return intel_spi_sw_cycle() directly in intel_spi_erase().
>   * Drop redundant elses.
>   * Fixed typo in the commit message of the patch 3/3.
>
> Mika Westerberg (3):
>   mtd: spi-nor: intel-spi: Disable write protection only if asked
>   mtd: spi-nor: intel-spi: Convert to SPI MEM
>   Documentation / MTD: Rename the intel-spi driver
>
>  Documentation/driver-api/mtd/index.rst        |   2 +-
>  .../mtd/{intel-spi.rst => spi-intel.rst}      |   8 +-
>  drivers/mfd/lpc_ich.c                         |  59 ++-
>  drivers/mtd/spi-nor/controllers/Kconfig       |  36 --
>  drivers/mtd/spi-nor/controllers/Makefile      |   3 -
>  drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 --
>  drivers/spi/Kconfig                           |  39 ++
>  drivers/spi/Makefile                          |   3 +
>  .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  49 ++-
>  .../spi-intel-platform.c}                     |  21 +-
>  .../intel-spi.c => spi/spi-intel.c}           | 357 +++++++++++-------
>  drivers/spi/spi-intel.h                       |  19 +
>  include/linux/mfd/lpc_ich.h                   |   2 +-
>  .../x86/{intel-spi.h => spi-intel.h}          |  12 +-
>  14 files changed, 367 insertions(+), 264 deletions(-)
>  rename Documentation/driver-api/mtd/{intel-spi.rst => spi-intel.rst} (94%)
>  delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (84%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (77%)
>  create mode 100644 drivers/spi/spi-intel.h
>  rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (64%)
>
> --
> 2.33.0
>
$ ./scripts/checkpatch.pl --file --strict drivers/spi/spi-intel.c
CHECK: Alignment should match open parenthesis
#215: FILE: drivers/spi/spi-intel.c:215:
+ dev_dbg(ispi->dev, " %02d base: 0x%08x limit: 0x%08x [%c%c]\n",
+ i, base << 12, (limit << 12) | 0xfff,

CHECK: Alignment should match open parenthesis
#232: FILE: drivers/spi/spi-intel.c:232:
+ dev_dbg(ispi->dev, " %02d base: 0x%08x limit: 0x%08x\n",
+ i, base << 12, (limit << 12) | 0xfff);

CHECK: Comparison to NULL could be written "!ispi->sregs"
#378: FILE: drivers/spi/spi-intel.c:378:
+ if (ispi->sregs == NULL && (ispi->swseq_reg || ispi->swseq_erase)) {

CHECK: Blank lines aren't necessary before a close brace '}'
#534: FILE: drivers/spi/spi-intel.c:534:
+
+ }

Beside these checks,
Reviewed-by: Mauro Lima <mauro.lima@eclypsium.com>
Thanks
