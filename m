Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D359E1D9589
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgESLrl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 07:47:41 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:9643 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESLrl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 07:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589888860; x=1621424860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+3WpN5wjU7vPXasZ7bMW3p7RrpJuTGFZkKzGqd78wTU=;
  b=vaTGPRDyfyzUeVHwCEAWhQ/JiOaN+YjoAOXkYPaa0iJl0cTa06A05u3l
   961k00rzhZN0NxVk8tB7UaziNvONXEmNvoBDOjnAZnjAQ/OBHRaizeeVA
   E/LmOshFKMLravZbZsc0k+zk3i61rCvFAZ12oeC2pb8+biGdNsbPrGUN2
   4LQHi6zULd5YK1JzN5TUE8Hqsstaikl38JsjMO+CcCfMkEn08FMvRpdoQ
   hc/g/6/ILW4+zHCY65rXn8py4+glBbynIriRCuXWaxTNgeZGy5GKjspOY
   4YSel8yIwhfKWQeaw2ozdUw1d/msa9CRLVnhSdTxePKPuaO5eYHzuYH0c
   A==;
IronPort-SDR: CXyWK6XjctxXloaSFb4QoNtDA6Ry52CMtVFwMWGs+0DsQUOSGUMc6G6B38mC5Es2J/SwA9BvfJ
 u2JGPnUnZlU1uhKCvY/i3hMw2dhY46AVqa3O0DaJyS1gj+DNK1eUoNoWXeNcXmFyZPfF1dlxwn
 cpxOIpB5rzwtywt157EitkEBohV4bwaDje/G7gEQzmpRy/Tqt/JjgMsaEHcBEZvD8q3/miLKAW
 oYUGUXzphVQVVBASFzBdtONiFD9Ojr/BOrWdJ9PRRxnYDB2dVNBnBuTrgtt2NGdPeEkwhhHuup
 ZXg=
X-IronPort-AV: E=Sophos;i="5.73,410,1583218800"; 
   d="scan'208";a="12828132"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2020 04:47:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 May 2020 04:47:40 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 19 May 2020 04:47:40 -0700
Date:   Tue, 19 May 2020 13:47:39 +0200
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: Re: [PATCH 04/10] dt-bindings: spi: Add bindings for spi-dw-mchp
Message-ID: <20200519114739.GD24801@soft-dev15.microsemi.net>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200513140031.25633-5-lars.povlsen@microchip.com>
 <20200513145213.GJ4803@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200513145213.GJ4803@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/05/20 15:52, Mark Brown wrote:
> Date: Wed, 13 May 2020 15:52:13 +0100
> From: Mark Brown <broonie@kernel.org>
> To: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>, Microchip
>  Linux Driver Support <UNGLinuxDriver@microchip.com>,
>  linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
>  linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
>  Alexandre Belloni <alexandre.belloni@bootlin.com>, Serge Semin
>  <Sergey.Semin@baikalelectronics.ru>, Serge Semin
>  <fancer.lancer@gmail.com>, Andy Shevchenko
>  <andriy.shevchenko@linux.intel.com>, Wan Ahmad Zainie
>  <wan.ahmad.zainie.wan.mohamad@intel.com>
> Subject: Re: [PATCH 04/10] dt-bindings: spi: Add bindings for spi-dw-mchp
> User-Agent: Mutt/1.10.1 (2018-07-13)
> 
> On Wed, May 13, 2020 at 04:00:25PM +0200, Lars Povlsen wrote:
> > This add DT bindings for the Microsemi/Microchip SPI controller used
> > in various SoC's. It describes the "mscc,ocelot-spi" and
> > "mscc,jaguar2-spi" bindings.
> 
> > Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> > ---
> >  .../bindings/spi/mscc,ocelot-spi.yaml         | 60 +++++++++++++++++++
> >  .../bindings/spi/snps,dw-apb-ssi.txt          |  7 +--
> 
> That's not what this change does.  It is removing the existing binding
> for Ocelot and Jaguar2 from the free format binding documentation and
> adds some entirely separate YAML bindings for them.  This conflicts with
> competing YAML conversions that both Serge Semin and Wan Ahmad Zainie
> (CCed) have in flight at the minute.  It also doesn't strike me as a
> good idea to fork the bindings, what's the motivation for doing that?

The reason for doing this was due to the fact that I felt adding
Sparx5 support only cluttered the original driver even more.

And since I was adding a new driver, I needed to add bindings for it -
and (re)move the old ones.

I have become aware of Serge and Wan Ahmad's work, and will work out
something on top of that.

