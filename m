Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE11D95EF
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgESMKK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 08:10:10 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:42150 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgESMKK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 08:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589890209; x=1621426209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7IyHvUdQbREBPZmSOudCaFMVAbLn7+9tZaDPBI7D298=;
  b=QUP/yW8TnbzVof2dW3biuzedw6r69w/yKPLeYoAIeVwTdY3SB5igCmXr
   RzBg4g+lr1X8Pn6cupp29KiveUWGTHjH/t0ga1kO25nF6Bkp6/n2sywpU
   264FmUJmskZild3OdKhRQusQ/0iUx7W1koc7BXn5xtwYvJD7OOzGYTUPt
   MVUgwfa4WR3Dhh7dkWEfjTOJ9JXmpJdv2Tg6ZsoHsobtK0Tkm0pWICwMx
   PFTRfj/TKtq9j6TpumQUgtGri/nCg6ywgrpWBGqUbCmQcTZOrpuRR+Ag6
   5YwA54C4c40kD2nYFr5blWLn0Ruitx7rvbwzA7h5uz1bhBxl0J9bDsvX2
   w==;
IronPort-SDR: 0PCZkTRMC2IQaaNZBy9q/R4cO5PFlRUjdc1l8stRhXgVbkdVk4vhPqBhy0PwEVJGbRqqrW6rLM
 9c06mq9YQchNhFqJ8nYip7fMjCzNS2AIr/ZKhL+PEB6RHWdU85Om+ySRXenJb98wLQj4i9PvGF
 wkGRU9Dia4gndlXv2HJS/0iE2l3ldoWmXDmf1bRZtrE+3RSKdVkwU5I06QlVVsXxFBWSVSV6cA
 Yt/kC7Sy549fdEMG474NUZ9dtOtD96OhTyUIvvW/sWUdyUbkB8i5UUiiKvfVJpEXwd+b7Gbzwk
 WeE=
X-IronPort-AV: E=Sophos;i="5.73,410,1583218800"; 
   d="scan'208";a="73869304"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2020 05:10:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 May 2020 05:10:08 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 19 May 2020 05:10:06 -0700
Date:   Tue, 19 May 2020 14:10:01 +0200
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
Message-ID: <20200519121001.GA26056@soft-dev15.microsemi.net>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200513140031.25633-5-lars.povlsen@microchip.com>
 <20200513145213.GJ4803@sirena.org.uk>
 <20200519114739.GD24801@soft-dev15.microsemi.net>
 <20200519115829.GI4611@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200519115829.GI4611@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19/05/20 12:58, Mark Brown wrote:
> Date: Tue, 19 May 2020 12:58:29 +0100
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
> On Tue, May 19, 2020 at 01:47:39PM +0200, Lars Povlsen wrote:
> > On 13/05/20 15:52, Mark Brown wrote:
> 
> > > On Wed, May 13, 2020 at 04:00:25PM +0200, Lars Povlsen wrote:
> > > > This add DT bindings for the Microsemi/Microchip SPI controller used
> > > > in various SoC's. It describes the "mscc,ocelot-spi" and
> > > > "mscc,jaguar2-spi" bindings.
> 
> > > That's not what this change does.  It is removing the existing binding
> > > for Ocelot and Jaguar2 from the free format binding documentation and
> 
> > The reason for doing this was due to the fact that I felt adding
> > Sparx5 support only cluttered the original driver even more.
> 
> That's not the issue I'm pointing out there.  The issue is that your
> changelog claims that the change does one thing and the change itself
> does something substantially different.

Ok, got it. I'll reword the changelog to be more precise.

Thanks again,

---Lars


