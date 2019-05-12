Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 513721AC45
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2019 15:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfELNI1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sun, 12 May 2019 09:08:27 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48785 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfELNI1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 May 2019 09:08:27 -0400
Received: from xps13 (unknown [109.190.253.16])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 404E5240004;
        Sun, 12 May 2019 13:08:10 +0000 (UTC)
Date:   Sun, 12 May 2019 15:08:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmail.com, paul.burton@mips.com, stefan@agner.ch,
        christophe.kerello@st.com, liang.yang@amlogic.com,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
        richard@nod.at, juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 1/4]  mfd: Add Macronix MX25F0A MFD controller driver
Message-ID: <20190512142835.4caddc8e@xps13>
In-Reply-To: <1555320234-15802-2-git-send-email-masonccyang@mxic.com.tw>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
        <1555320234-15802-2-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Mon, 15 Apr 2019 17:23:51
+0800:

> Add a driver for Macronix MX25F0A multifunction device controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mfd/Kconfig              |   9 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/mxic-mx25f0a.c       |  84 +++++++++++++++++++
>  include/linux/mfd/mxic-mx25f0a.h | 175 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 269 insertions(+)
>  create mode 100644 drivers/mfd/mxic-mx25f0a.c
>  create mode 100644 include/linux/mfd/mxic-mx25f0a.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 26ad646..7e99e93 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -823,6 +823,15 @@ config MFD_MAX8998
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_MXIC_MX25F0A
> +	tristate "Macronix mx25f0a multifunction device support"
> +	select MFD_CORE
> +	help
> +	  This supports for Macronix mx25f0a multifunction device controller
> +	  for raw nand or spi. You have to select individual components like

Please use upper case for acronyms in plain English: NAND, SPI

> +	  raw nand controller or spi host controller under the corresponding
> +	  menus.
> +
>  config MFD_MT6397
>  	tristate "MediaTek MT6397 PMIC Support"
>  	select MFD_CORE

Thanks,
Miquèl
