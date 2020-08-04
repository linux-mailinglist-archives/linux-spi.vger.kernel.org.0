Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E499A23B517
	for <lists+linux-spi@lfdr.de>; Tue,  4 Aug 2020 08:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgHDGlX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Aug 2020 02:41:23 -0400
Received: from mailout11.rmx.de ([94.199.88.76]:39641 "EHLO mailout11.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgHDGlW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 4 Aug 2020 02:41:22 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout11.rmx.de (Postfix) with ESMTPS id 4BLQBk6YTbz41h3;
        Tue,  4 Aug 2020 08:41:18 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BLQBN1kYlz2TTKG;
        Tue,  4 Aug 2020 08:41:00 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.81) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Aug
 2020 08:40:53 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eeprom: at25: allow page sizes greater than 16 bit
Date:   Tue, 4 Aug 2020 08:40:52 +0200
Message-ID: <9183924.TykLrII94J@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200727111218.26926-1-ceggers@arri.de>
References: <20200727111218.26926-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.81]
X-RMX-ID: 20200804-084104-4BLQBN1kYlz2TTKG-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Ping?

On Monday, 27 July 2020, 13:12:18 CEST, Christian Eggers wrote:
> Storage technologies like FRAM have no "write pages", the whole chip can
> be written within one SPI transfer. For these chips, the page size can
> be set equal to the device size. Currently available devices are already
> bigger than 64 kiB.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  drivers/misc/eeprom/at25.c | 2 +-
>  include/linux/spi/eeprom.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index cde9a2fc1325..0e7c8dc01195 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -261,7 +261,7 @@ static int at25_fw_to_chip(struct device *dev, struct
> spi_eeprom *chip)
> 
>  	if (device_property_read_u32(dev, "pagesize", &val) == 0 ||
>  	    device_property_read_u32(dev, "at25,page-size", &val) == 0) {
> -		chip->page_size = (u16)val;
> +		chip->page_size = val;
>  	} else {
>  		dev_err(dev, "Error: missing \"pagesize\" property\n");
>  		return -ENODEV;
> diff --git a/include/linux/spi/eeprom.h b/include/linux/spi/eeprom.h
> index aceccf9c71fb..1cca3dd5a748 100644
> --- a/include/linux/spi/eeprom.h
> +++ b/include/linux/spi/eeprom.h
> @@ -14,7 +14,7 @@
>  struct spi_eeprom {
>  	u32		byte_len;
>  	char		name[10];
> -	u16		page_size;		/* for writes */
> +	u32		page_size;		/* for writes */
>  	u16		flags;
>  #define	EE_ADDR1	0x0001			/*  8 bit addrs */
>  #define	EE_ADDR2	0x0002			/* 16 bit addrs */




