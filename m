Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524B0353C6A
	for <lists+linux-spi@lfdr.de>; Mon,  5 Apr 2021 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhDEIec (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Apr 2021 04:34:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51756 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhDEIec (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Apr 2021 04:34:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1358YIgH001353;
        Mon, 5 Apr 2021 03:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617611658;
        bh=vjydxmGku5rf0yRyw4g2LgzWuCMb6BltUJU8Anl8Yps=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sRjWJoZV6zqsAUMUpu9bxu30imuYFpf/WQ4x1BbHoCCkGAEvbOgbBHgOSD1f6gP68
         wQ4yc9eP+zHaxCOIX4PqzhbcBXOOnZM1jcHexmYJ/b63ktO5bU8DDuJPlXeLqnaLnH
         w20rVGg1pEOPfGDWtzCxB+IYN9SE+Xhk3OIf1RU4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1358YIO5059945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Apr 2021 03:34:18 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 5 Apr
 2021 03:34:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 5 Apr 2021 03:34:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1358YHjH007138;
        Mon, 5 Apr 2021 03:34:18 -0500
Date:   Mon, 5 Apr 2021 14:04:17 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 4/4] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20210405083415.x6azwdzanvsbiljn@ti.com>
References: <20210331193930.tzsvbjup3wpxmh26@ti.com>
 <20210401141328.GH4758@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210401141328.GH4758@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/04/21 03:13PM, Mark Brown wrote:
> On Thu, Apr 01, 2021 at 01:09:32AM +0530, Pratyush Yadav wrote:
> 
> > I did take a look by running git log on 
> > Documentation/devicetree/bindings/spi/ and there is no single style 
> > being used. Using "dt-bindings: spi:" is a popular choice. Some other 
> > commits just use "spi:". And then some use "spi: dt-bindings:". The last 
> > commit to touch cadence-quadspi.txt (fcebca39938f) used the prefix 
> > "dt-bindings: spi:".
> 
> Yes, lots of people pick unfortunate subject lines for DT patches - that
> doesn't mean it's good.  I'm looking to see spi: same as for all other
> SPI patches.

All right. "spi: dt-bindings:" it is from now on.

> 
> > So on the prefix front I think the subject is good enough. Of course, if 
> > you have any other preference then it can be re-worded but let's first 
> > be clear on what the expectation is. And then let's make sure to apply 
> > it to all future patches uniformly. This way future contributors won't 
> > have to take a guess on what the expected prefix is.
> 
> I do edit some percentage of patches, but some do slip through for
> various reasons.  There's also some things that just get completely
> missed, especially if there isn't also a code patch nearby.
> 
> > Apart from the prefix is there anything else to improve? IMHO the 
> > subject is good enough but I'm open to suggestions.
> 
> There was the thing with constraints.

Will send a follow up patch to add the constraints that Vignesh 
suggested.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
