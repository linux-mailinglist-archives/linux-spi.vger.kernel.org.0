Return-Path: <linux-spi+bounces-10126-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D210B85761
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 17:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568F43AC936
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC21FF1A1;
	Thu, 18 Sep 2025 15:04:58 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17271EB36;
	Thu, 18 Sep 2025 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207898; cv=none; b=FaFgPwAnre18JwqUB48uIMPAQ6vnaS/0SZx6+a/fsgusvMYAQk5YCxkAXmPinJj/ya+4794/mvJoaOd6CNCOzqjVIGANDRusKrmmoVUw8K49f5TVeJLoOUlKzJ77o56+9iZkC9IeOk/yY5uwCWBfMjUfMJZemDNgwPsW0UUb2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207898; c=relaxed/simple;
	bh=4PZfLFnOxLVq3nXJlAJ9Bj7bNfCQqBZqH9+lTJiqVhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8P5J1ZJiptcU46YmaKGQAd/Ja53+3u4ZTD8tIZIQ6cfiqHlU9sU97lSho74EKHU3XYmLfe6hqq2Ewd4/rL1xYOEcvThQsCLIB6kx5rX200KSrDDgoY6+4d9lYHROcOzEPbqFvHnBFMX/UMS9SeTEZGB1FX5QVuhA3FGmGB8+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C2BEC34210A;
	Thu, 18 Sep 2025 15:04:55 +0000 (UTC)
Date: Thu, 18 Sep 2025 23:04:50 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: dts: spacemit: define a SPI controller node
Message-ID: <20250918150450-GYD1274501@gentoo.org>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-4-elder@riscstar.com>
 <20250918133209-GYB1273705@gentoo.org>
 <5956e320-7cbb-4d9a-95a7-720cfa6b9654@riscstar.com>
 <20250918140633-GYA1274501@gentoo.org>
 <0053c0ca-340f-46fd-adb1-6af6928717ee@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0053c0ca-340f-46fd-adb1-6af6928717ee@riscstar.com>

Hi Alex,

On 09:20 Thu 18 Sep     , Alex Elder wrote:
> On 9/18/25 9:06 AM, Yixun Lan wrote:
> > Hi Alex,
> > 
> > On 08:51 Thu 18 Sep     , Alex Elder wrote:
> >> On 9/18/25 8:32 AM, Yixun Lan wrote:
> >>>> +			spi3: spi@d401c000 {
> >>>> +				compatible = "spacemit,k1-spi";
> >>>> +				reg = <0x0 0xd401c000 0x0 0x30>;
> >>>> +				#address-cells = <1>;
> >>>> +				#size-cells = <0>;
> >>>> +				clocks = <&syscon_apbc CLK_SSP3>,
> >>>> +					 <&syscon_apbc CLK_SSP3_BUS>;
> >>> ..
> >>>> +				clock-names = "core",
> >>>> +					      "bus";
> >>> can you simply put them together in one line? it's kind of tedious to split..
> >>
> >> Sure I can do that.  I've seen it both ways.
> >>
> > right, it's merely a coding style I want to enforce, to make it slightly consistent
> > 
> >>>> +				resets = <&syscon_apbc RESET_SSP3>;
> >>>> +				interrupts-extended = <&plic 55>;
> >>> why use interrupts-extended?
> >>
> >> Because it specifies both the controller and interrupt number
> >> explicitly.  Why *not* use interrupts-extended?
> >>
> > It's just unnecessary, the SPI node will fall back to find parent node's interrupt
> > which already specific as &plic, brings no benefits
> 
> The benefit it brings is that I don't have to search backward to
> see what the interrupt controller is.  I realize it's redundant
> but I do prefer interrupts-extended over just interrupts.
> 
although both should work fine, I do prefer simple "interrupts" version
for dts wide consistence, at least for SpacemiT

while reading Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
interrupts-extended is useful when there are multi interrupt parents, or need
to specific different one..

Yes, we have different opinion here, let's wait and see what DT maintainer think

-- 
Yixun Lan (dlan)

