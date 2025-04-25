Return-Path: <linux-spi+bounces-7755-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE26A9BE3D
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 07:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349F3176968
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 05:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4439B22A4F0;
	Fri, 25 Apr 2025 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEB75zzO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C8CA6B;
	Fri, 25 Apr 2025 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560764; cv=none; b=s81tr1GdsyrISrKmB4z0eHea/vyq1p24MLUcE4uwTcgTIF7WRGHvn8FkvsjkyZFQ7Tj/X/9654bTiMc39jcW2Yxlfi1yQ6OQX5jiJRSzXrGwS1QcrKnyEGYfgIvcQNaMIDz/TstmH2UcLPN7Ig909eG+bF9LGOR+HL32qFvXNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560764; c=relaxed/simple;
	bh=GLp1ktjFa7K3wjwfc/rJPiarptC1W+shUho7laLH4QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pah7bOPkZ1I34F1FQ9vnL5yvrAhe2VmZPSBdx6K7zqG9k5QLxtY4TaciCw/FnuTQNa06tEAnzXe1EJpnTsObXlYeTC3W/2Sv+MyAXCWbx5FY6g81/HuL9zh/5p+mifG5xw+W3BTlPpk5fkvdLqJM03MwP/W+a46HUYiz7KkM8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEB75zzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2388C4CEE4;
	Fri, 25 Apr 2025 05:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745560763;
	bh=GLp1ktjFa7K3wjwfc/rJPiarptC1W+shUho7laLH4QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEB75zzOCleMN1u4qU3hI0/g19GzAUy2M4ejlMLMuvN3pDW3JLiLvdbOFayRSHEKq
	 VQLk2z04wzXPeZGTEt+Bf56fI1AC9cmfAeSmNkOOc/zoP1/QykCMMNSF6XcjXOAcCJ
	 yxTUAnYy1w4lEx0KA7CS0uRYVFRetp5ytT3t/hpZ6W6ddjFQ5XwPNxVUphz5eBlWR8
	 iTAubyJLavL2lK132zU0OUS8KhXcl04eCWwtKnKK31lAvEZk90id4BvI7xjDIFYWz4
	 z367m6L8C0kf6TeQAuhh5OU/RWrzRJKk7c7TwomYxT00sdb3YhwYau/arEN+TgFbzp
	 /HFETG4ueoMGQ==
Date: Fri, 25 Apr 2025 07:59:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, sophgo@lists.linux.dev, 
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, dlan@gentoo.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 2/3] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for SOPHGO SG2042 SoC
Message-ID: <20250425-prudent-ara-of-chivalry-bfffb5@kuoka>
References: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
 <20250425-sfg-spi-v6-2-2dbe7bb46013@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425-sfg-spi-v6-2-2dbe7bb46013@gmail.com>

On Fri, Apr 25, 2025 at 10:28:13AM GMT, Zixian Zeng wrote:
> Sophgo SG2042 ships an SPI controller [1] compatible with the Synopsys
> DW-SPI IP. Add SoC-specific compatible string and use the generic one
> as fallback.
> 
> Link: https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/SPI.rst [1]
> 
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


