Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20033D1393
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhGUPdL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 11:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232058AbhGUPdK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Jul 2021 11:33:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75650608FC;
        Wed, 21 Jul 2021 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626884027;
        bh=BfWv9+DmC2M4MaAgj5Yu9VvVrTvFWwy5GGEmFJQqh+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZr1sX5/jpk5/qW5wZhLE1iyThehwYf6o03oa7byMHTOXPH+PTCc4uNMTRzJatV2M
         kSAOEefH9FmhzbIwiZsE7o3a3cXvlWG8nHLkWbDnMI6R0pcZLxE+vbotJzbJ0rzd4K
         f2Q82XrMj6hFkCf5xTSt3hSayIOsOj3MltIqmU8Y=
Date:   Wed, 21 Jul 2021 18:13:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv7 3/3] misc: gehc-achc: new driver
Message-ID: <YPhHuNkDPS5EH7s9@kroah.com>
References: <20210713163528.119185-1-sebastian.reichel@collabora.com>
 <20210713163528.119185-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210713163528.119185-4-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 13, 2021 at 06:35:28PM +0200, Sebastian Reichel wrote:
> General Electric Healthcare's PPD has a secondary processor from
> NXP's Kinetis K20 series. That device has two SPI chip selects:
> 
> The main interface's behaviour depends on the loaded firmware
> and is currently unused.
> 
> The secondary interface can be used to update the firmware using
> EzPort protocol. This is implemented by this driver using the
> kernel's firmware API. The firmware is being flashed into
> non-volatile flash memory, so it is enough to flash it once
> and not on every boot. Flashing will wear the flash memory
> (it has a life time of at least 10k programming cycles) and
> takes 3 minutes with the microcontroller being unusable. At
> the same time only occasional FW updates are expected (like e.g.
> a BIOS update). Thus the firmware update is triggered via sysfs
> instead of doing it in the driver's probe routine like many
> other drivers.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../ABI/testing/sysfs-driver-ge-achc          |  14 +
>  drivers/misc/Kconfig                          |  11 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/gehc-achc.c                      | 542 ++++++++++++++++++
>  drivers/spi/spidev.c                          |   1 -
>  5 files changed, 568 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-ge-achc
>  create mode 100644 drivers/misc/gehc-achc.c

This patch gives me build warnings:

drivers/misc/gehc-achc.c: In function ‘ezport_firmware_compare_data’:
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro ‘__careful_cmp’
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
drivers/misc/gehc-achc.c:305:33: note: in expansion of macro ‘min’
  305 |                 transfer_size = min((u32) EZPORT_TRANSFER_SIZE, size - address);
      |                                 ^~~
drivers/misc/gehc-achc.c: In function ‘ezport_firmware_flash_data’:
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro ‘__careful_cmp’
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
drivers/misc/gehc-achc.c:347:33: note: in expansion of macro ‘min’
  347 |                 transfer_size = min((u32) EZPORT_TRANSFER_SIZE, size - address);
      |                                 ^~~


How did you test build this?

thanks,

greg k-h
