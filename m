Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE3482FB8
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jan 2022 10:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiACJ6E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jan 2022 04:58:04 -0500
Received: from 9.mo575.mail-out.ovh.net ([46.105.78.111]:53001 "EHLO
        9.mo575.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiACJ6E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jan 2022 04:58:04 -0500
X-Greylist: delayed 1017 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 04:58:04 EST
Received: from player773.ha.ovh.net (unknown [10.109.156.6])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 0AA3C23631
        for <linux-spi@vger.kernel.org>; Mon,  3 Jan 2022 09:41:05 +0000 (UTC)
Received: from etezian.org (82-181-27-157.bb.dnainternet.fi [82.181.27.157])
        (Authenticated sender: andi@etezian.org)
        by player773.ha.ovh.net (Postfix) with ESMTPSA id 4A0D425FD0C77;
        Mon,  3 Jan 2022 09:40:55 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-104R005d8f6c1c1-938a-4caf-be9f-e653b6a788c1,
                    1C8846252225BEA48CFC69899B133A5ED785C568) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 82.181.27.157
Date:   Mon, 3 Jan 2022 11:40:54 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: exynos: split dmas into array of phandles
 in Exynos5250
Message-ID: <YdLEprsh3i3/oRVb@jack.zhora.eu>
References: <20220102155807.42758-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102155807.42758-1-krzysztof.kozlowski@canonical.com>
X-Ovh-Tracer-Id: 14172828029060975128
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrudefuddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihesvghtvgiiihgrnhdrohhrgheqnecuggftrfgrthhtvghrnheptdfgudduhfefueeujeefieehtdeftefggeevhefgueellefhudetgeeikeduieefnecukfhppedtrddtrddtrddtpdekvddrudekuddrvdejrdduheejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjeefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof,

On Sun, Jan 02, 2022 at 04:58:06PM +0100, Krzysztof Kozlowski wrote:
> "dmas" property should be rather an array of phandles, as dtschema
> points.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
