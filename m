Return-Path: <linux-spi+bounces-7711-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9212A9635B
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 11:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61351885CCA
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7B256C86;
	Tue, 22 Apr 2025 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd+/1hHg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002C1E9B37;
	Tue, 22 Apr 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311838; cv=none; b=PENX0XhW7UDRo1yFJf0DR8F+U2+v4xQL9zf5kD6HRFsFMUThl1DhQ4caXyaY6QUHJVCYYIax8XsWLt+cxesm4eB1XhifoGnlHdCSNR0+4EMqWAQwHp7SkuGruq6zqpEPqLRCbfJVxMFMjjxUSiqPJIucVjXjdmiISnGXLw9oA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311838; c=relaxed/simple;
	bh=zT5yjxc1BjzTyrF7qU74cHTpuWHBzYOk4qyMnCNGTHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivmOSc5cyWVDHpnDfRtfNFLeGDOKQmOO7tAQPAuFMcrNeKJu7TIZg2ks+KN6F0ZslRVMsDZ348LFFx6Qif0mEhdNiyHCyZY9sHF4yloLjAxpb/Hy3/FHvx708cF2R6r0bbsxEjamWCVfXJF+uAJFv1TE9IBXa/gJQPDDHVwX2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd+/1hHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC458C4CEE9;
	Tue, 22 Apr 2025 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745311837;
	bh=zT5yjxc1BjzTyrF7qU74cHTpuWHBzYOk4qyMnCNGTHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yd+/1hHgLMKAkVj5RRoxdtfnlZvK1uI+LWg7GeK5M7op2BTQbEt3E1GQzqqDCAx3O
	 4ktpx0Uki5Ub3ZQqHJuHeLAyNfUt7LTucKDPSaPQF7JTirLi5GOQ9KIjUbvwe06P/Z
	 cdAP/YmPAq/PfQcfhfHIFk2qtwvJvl1o5FujvGoYLq1/nIQkHM+wlYACfH55/MQgmN
	 DglqVLwpW5Y3PBwzvSbi37lHwFjF2Fqfv9OH3B18VVwhpgVoV67X3+CQQQOft3ht3Y
	 o69MQnmF2YrNOLhe1/jOFxWICf2rgJVeDMq3PM/AZkdQrc7dTZ2wS2+CcGr50H7D2s
	 KMZplLLJazrAA==
Date: Tue, 22 Apr 2025 10:50:34 +0200
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
Subject: Re: [PATCH v5 2/3] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for SOPHGO SG2042 SoC
Message-ID: <20250422-super-giraffe-of-drizzle-b388bf@kuoka>
References: <20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com>
 <20250422-sfg-spi-v5-2-c7f6554a94a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422-sfg-spi-v5-2-c7f6554a94a0@gmail.com>

On Tue, Apr 22, 2025 at 10:27:09AM GMT, Zixian Zeng wrote:
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
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index a43d2fb9942d85b1482a52782c0a97cd5c6edd99..d32380a2e5b18f61ed66715b4ac67c04fbda10ef 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -67,6 +67,7 @@ properties:
>                - mscc,jaguar2-spi
>                - renesas,rzn1-spi
>                - thead,th1520-spi
> +              - sophgo,sg2042-spi

Messed order. s goes before t.

Best regards,
Krzysztof


