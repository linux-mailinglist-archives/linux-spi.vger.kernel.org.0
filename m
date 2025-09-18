Return-Path: <linux-spi+bounces-10095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC13B825C6
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 02:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52531C201CB
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8C7E107;
	Thu, 18 Sep 2025 00:16:40 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E617E4;
	Thu, 18 Sep 2025 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758154600; cv=none; b=LwSZEYd3M6ooWX7DEpsZiI93RW42XnkFqw1rspltUvHBZzlfgqlefzKZdnhu300yHTNBd2Ss7iSWIEFBNBdr5sYxndxax3fBsAuJidIQA+Ub8nYnnR6kXlPheoiq0+LqBcnRmaYw12kEr7Y6GnSrRJfeSzqQ319u43a8SooZJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758154600; c=relaxed/simple;
	bh=aM69JB3qcCuXtg0u/toiNobtTe6qDc1VMbFfyhjwRnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU02ySiwhCsg+41cWzgkbeRGXUyyEcwnruAO/vMfxpCsuYdNmxgJx/aHHRUwOBCfTUtn4zqTABzatx0Bg0sOBj79uaorZ4F/6XjU8Dh1dIcdOP2hxI3XJzZK6B58zB/Y8S+zIAT3aNNOcNpKv16lTwJBsNhPBgNZyQH1Nt56Qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4A5493410AF;
	Thu, 18 Sep 2025 00:16:37 +0000 (UTC)
Date: Thu, 18 Sep 2025 08:16:32 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Message-ID: <20250918001632-GYA1270371@gentoo.org>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-2-elder@riscstar.com>
 <20250917231520-GYA1269891@gentoo.org>
 <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>

Hi Alex,

On 18:40 Wed 17 Sep     , Alex Elder wrote:
> On 9/17/25 6:15 PM, Yixun Lan wrote:
> > Hi Alex,
> > 
> > On 17:07 Wed 17 Sep     , Alex Elder wrote:
> >> Add support for the SPI controller implemented by the SpacemiT K1 SoC.
> >>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>
> >> ---
> >>   .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
> >>   1 file changed, 94 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> >> new file mode 100644
> >> index 0000000000000..5abd4fe268da9
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
..
> >> +
> >> +  spacemit,k1-ssp-id:
> >> +    description: SPI controller number
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > could you explain a little bit why this vendor specific property should
> > be introduced? I took a look at the code, and didn't get the reason
> > behind.. or what's the problem of simply using "pdev->id"?
> 
> This property was carried over from the vendor code.  It is
inherit from vendor code isn't a valid reason

> optional, and if it isn't specified, the platform device ID (-1)
> will be used.  It's just intended to provide a well-defined ID
> for a particular SPI controller.
> 
while looking at the code, it seems you can use alias to map specific id
to the spi controller, it even can do non-linear map, something like
	spi0 = &spi3;

plese check of_alias_get_id()

note, I haven't actually verified on board, just look through the code

> > we should really be careful to introduce vendor specific property..
> 
> If there were a standard way of doing this I'd love to use it.
> 
> And if it isn't necessary, please just explain to me why.  I
> have no problem removing it.
> 
on the opposite, please have explicit good reason to introduce vendor
speifici property, and if there is generic way, then we shouldn't do it

-- 
Yixun Lan (dlan)

