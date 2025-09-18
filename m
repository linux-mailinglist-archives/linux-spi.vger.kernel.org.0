Return-Path: <linux-spi+bounces-10097-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF64B8360A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 09:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D6B3A3DE3
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C9B2EA476;
	Thu, 18 Sep 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="v+gxEhpr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B9275AF6;
	Thu, 18 Sep 2025 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181464; cv=none; b=nC3OQypSRXDqefAPWVBDLgwiJfEXx3PhanA2Ub5JXlPwOJ1QVqtpcLM+w/E2QgEG/mMPe7I0Kh1N6a/iLYZCvQb3VWfi3yjuffNcBDEtp4Z0Vh8cXv5BAEIKmwspsQVJe/Uhz14i5MiXGHAwohWkmflaUcfMxqMGgKw6NsC74vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181464; c=relaxed/simple;
	bh=dmM/nfY9ZGJWZNd9QVwh8AdV4xV1NZFaRSTZnw0XJTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEt93WK7tijZ7c81m718RWtGxbIC6+RXGPq7a1/F2SIAdyu2kPq5lVTBvKCVoAM63Pzyq+1A/6iE8d+cvCuQoF+2PVXEJZbJ2PpKixx4BcYaetFZwVlyaEeVnSfU+eT+Beil9gImLnbJqCvROYYyMZr1HmftKYE1qcluLMsCLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=v+gxEhpr; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758181416;
	bh=fKIhYdZo0gbuLJoLY01IaGGDghYLeBAKJXGGD1WoNs4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=v+gxEhprMaNkI5zdgN3ffLbhETn4ksZ9PUxQaVD6hQ/8w/SXZf/4phNPyGTtjw9GM
	 KOf7JQlCkrWXY68DIem3/Nl1xVxmZN0zBn3uueOijScjCamido4SQyXYzy1k/jo8VE
	 6Hb0EL0LBRZyfsrQ0jISm8tlje7qUxIS45au72yo=
X-QQ-mid: esmtpsz11t1758181409t25a73e83
X-QQ-Originating-IP: TBFWLYNJiVsLazlBh4iNqndLkAwUI57Zz+YC92McJmE=
Received: from = ( [120.239.196.247])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Sep 2025 15:43:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8956593677624534324
EX-QQ-RecipientCnt: 17
Date: Thu, 18 Sep 2025 15:43:27 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Alex Elder <elder@riscstar.com>, Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Message-ID: <D2A109C6A8BDED08+aMu4H4xap2GSP50w@LT-Guozexi>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-2-elder@riscstar.com>
 <20250917231520-GYA1269891@gentoo.org>
 <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>
 <20250918001632-GYA1270371@gentoo.org>
 <f7e12797-ea17-4e92-bd25-cc562c66d2a7@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e12797-ea17-4e92-bd25-cc562c66d2a7@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MwQdfXoP8nuzwjcN1/JTOvKPKAJ/Oqc5WU5eoCinbQrbmJofDHOfXHAI
	nD6eYPOhuTd/C7wEbm1r63oWEtnHFHcNqRkPSg0+n+c9wrEL6SyrAnmnZtbFXbRYzqXBZXU
	aWRKP6zQIz1saboU1rVI2QQzkAqUFHys82st5LEjXxL/53syfVIhhUvUrYLxuAcYPXIAHNQ
	cju6RjK78O2O/B1d7+fLlNWRjHM9h7/aCGqMieymarcitoYPFChqjLKbuSbJ9N7gqoTURmV
	Be6DYxdOTlhY0C1vUJZLIPKnuzO7RcE6hwjYLT4JxMcGCy7ucrN0wRXjNbPxBiFb+Fo82Qv
	Hd4lYreY0eab/MrLrvP1xFTZUbLAEmSuEybLBk4AZkNZLdO/MYH/DlPfW+jsMxl8n4gW12S
	UIMU8238GPq1qQZXzvHG3zNzdbM4mzulmvjFFhZEWRTxPQP6LOIk+Cp7KdlO6DwYNSR4DTb
	wuHAUtwHKmTr9wqpTj8ZDSvtgnwE8Z/grF2AcNR0qOHQpX52JXocoo5Trbb8PIIkdOWpMhR
	7+sNHL/6JFOQ3Hpcx1nJFQxDYttNoUBsiNwL0rw8anViz/cKaGJln6/XqpjvmH0YPnUW1H2
	+LB0BwGkVf/feuBSiUq5e9vNA25DdD4ynvM8DJ+oCr8AafRdxjcYFv44enLoCOlKoN8vwja
	zARIVqzTNLNm0gOR4M2F3DcTyzboo6uH3FzjZBPooMyb6N6mSPG/zWVhW2lOrTIq+0kLTb3
	idXbE0MtaNV2D7yYa56dL0DeXoeZmxonnLgganPp1MBugZSyQxRdi0dLB1ERE/3qpGd03Ie
	U6/azKQNzEyjt5ANkh7tpcMck9LgFxi54tqVhreuBpGhgbCmwRVhteK9kn+yj3/QVJEI7BS
	9lHMPop8lqmnptKLu5gy7rCsVIVhud10t5cvK93LQMEy0c/Xub60g0o0/QF9MR2hUgRx5ru
	+FCtAQRS34wRtd2NkUmQY/dSR9LC/K309IQMt7tb/j0ItNIFwyBvLBjRWUUGat8AqfvHsUp
	Fb+TWq/g46d6YPeOJa4FXXml8R8iUnKNA7biLb3qqcUcRSFs9xO/FtgwLUV0M=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Wed, Sep 17, 2025 at 09:59:35PM -0500, Alex Elder wrote:
> On 9/17/25 7:16 PM, Yixun Lan wrote:
> > Hi Alex,
> > 
> > On 18:40 Wed 17 Sep     , Alex Elder wrote:
> > > On 9/17/25 6:15 PM, Yixun Lan wrote:
> > > > Hi Alex,
> > > > 
> > > > On 17:07 Wed 17 Sep     , Alex Elder wrote:
> > > > > Add support for the SPI controller implemented by the SpacemiT K1 SoC.
> > > > > 
> > > > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > > > ---
> > > > >    .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
> > > > >    1 file changed, 94 insertions(+)
> > > > >    create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> > > > > new file mode 100644
> > > > > index 0000000000000..5abd4fe268da9
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> > ..
> > > > > +
> > > > > +  spacemit,k1-ssp-id:
> > > > > +    description: SPI controller number
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > could you explain a little bit why this vendor specific property should
> > > > be introduced? I took a look at the code, and didn't get the reason
> > > > behind.. or what's the problem of simply using "pdev->id"?
> > > 
> > > This property was carried over from the vendor code.  It is
> > inherit from vendor code isn't a valid reason
> > 
> > > optional, and if it isn't specified, the platform device ID (-1)
> > > will be used.  It's just intended to provide a well-defined ID
> > > for a particular SPI controller.
> > > 
> > while looking at the code, it seems you can use alias to map specific id
> > to the spi controller, it even can do non-linear map, something like
> > 	spi0 = &spi3;
> I've never used this before, but yes, it looks like it's exactly
> what I want.  I'll just get rid of the "spacemit,k1-ssp-id" DT
> property entirely.  Easy.
> 
> > plese check of_alias_get_id()
> > 
> > note, I haven't actually verified on board, just look through the code
This is the right API that Alex what to use.
I have verified it in i2c driver.

                - Troy

> > 
> > > > we should really be careful to introduce vendor specific property..
> > > 
> > > If there were a standard way of doing this I'd love to use it.
> 
> Looks like you have told me the standard way of doing this.
> 
> Thank you.
> 
> 					-Alex
> 
> > > 
> > > And if it isn't necessary, please just explain to me why.  I
> > > have no problem removing it.
> > > 
> > on the opposite, please have explicit good reason to introduce vendor
> > speifici property, and if there is generic way, then we shouldn't do it
> > 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

