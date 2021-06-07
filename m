Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356939E85D
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFGU0v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 16:26:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40098 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhFGU0v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 16:26:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157KOtqb003693;
        Mon, 7 Jun 2021 15:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623097495;
        bh=soaO8j6FeW+HBW6qIKwrpmt+kh6ODk1iTx9WHdjq7J0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=anyt0Jvfd4rh5v8/d3gqR51gobNXklYkl/fiGPoq69zsNpgbYny/riM/DByfHEPAY
         Qc8qpCM44B1A+Kl0/pdWzn2TezAeIevBSOBNOOU6qwq0gjuSot3k7uIIE06vnuzTfV
         MiLyx+6I+qd+AHRM14yk8Qfkvy5X5aRpUL7+Ogsg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157KOt7r037883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 15:24:55 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 15:24:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 15:24:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157KOsZK127941;
        Mon, 7 Jun 2021 15:24:54 -0500
Date:   Mon, 7 Jun 2021 15:24:54 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in
 property with dt-shema
Message-ID: <20210607202454.7rhc7ufiphgrhqqx@rejoice>
References: <20210602123416.20378-1-a-govindraju@ti.com>
 <20210602123416.20378-4-a-govindraju@ti.com>
 <20210607134047.isfuedgjxpubpcb5@ungloved>
 <9e27bd14-e16a-4177-bba8-d5d0e5638f04@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9e27bd14-e16a-4177-bba8-d5d0e5638f04@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19:18-20210607, Aswath Govindraju wrote:
> Hi Nishanth,
> 
> On 07/06/21 7:10 pm, Nishanth Menon wrote:
> > On 18:04-20210602, Aswath Govindraju wrote:
> >> ti,pindir-d0-out-d1-in property is expected to be of type boolean.
> >> Therefore, fix the property accordingly.
> >>
> >> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> > No need for Fixes?
> > 
> 
> Functionality wise this is not a bug as the driver only checks for the
> presence of the property. This is the reason why I did not include fixes.
> 

Argument was based on device tree is considered independent of what or
what not a driver does.

> > Also please split up the patches per maintainer so that we are'nt
> > confused on who should pick what etc..
> > 
> 
> okay. Will be aware of this from next time.
> 

Actually, I have dropped this off my list. I am assuming you'd want the
bindings to be merged after the dts cleanup is done.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
