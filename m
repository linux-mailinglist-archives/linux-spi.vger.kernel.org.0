Return-Path: <linux-spi+bounces-7409-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F5FA7E0C6
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 16:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BC13AE3D1
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54301C5D6A;
	Mon,  7 Apr 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVtMEVp7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5D1C54A6;
	Mon,  7 Apr 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034862; cv=none; b=ruJEjIlGcoyGpRzosdbK6mFOgVy9MSUcmqv5CYeOry8k8MR/nuVe69mJ8XqBPMd1iAMfufUeG0DUMgOkkVrbIqamCu8vrFMUfwUA6G/ifGPFnvycu7Okelj/JDieyccjw1MyNAT7ykP6ZA3TF2WStJCIa/u6LsbAF0sUkijEZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034862; c=relaxed/simple;
	bh=TaujOUNY4+EkrJXwK4q0mvwGc8rH8Q3ZdBnCxuWnWYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIlDIi1DCc0fyBvlmYZYfQFts1UmKSlv0d6C9k2PNuAV3BT9aGPLVkex41p6Cv1eMT3QnRobyqw7CyogMv5vkzZap2FRvdlq+BeldhsQR00wvk6uSWUejVp9nh331prquF2Aqvm90pyXB0BpwpfPMx0duH1KVsfycOmgtNBYTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVtMEVp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C053FC4CEDD;
	Mon,  7 Apr 2025 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744034861;
	bh=TaujOUNY4+EkrJXwK4q0mvwGc8rH8Q3ZdBnCxuWnWYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVtMEVp7APvFMAMDPfhn2yiDcq2izHGAQlMMWiPOoJwr+963UufgWNee3eLIFVFyU
	 DfJY3Fjp+29pbzG9eo5FpmuOxsmDFCTMp+C1UleMdOibV3YOCTBep+huhmU1BMJP/M
	 Dn55qS1ZvyrYeU0hMswrMaxHpk77qyncbDtsZYK7QShkChdL4UWZa+6SGpeLQ8vjM7
	 gRdaghF80Olla4zzvrnEl4ySwUgoZR/+3suNZo8zhkQ5Iqog4w7/xEuN0S9oH7S+o8
	 Qwqkj9mGIhRROpgvtO1SB4v2jXsM6fHHYFNzz6iIWT3KB/O/8m+JYJmyM34WoGkJhw
	 vhIEoDBDfBYcw==
Date: Mon, 7 Apr 2025 09:07:39 -0500
From: Rob Herring <robh@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, sophgo@lists.linux.dev,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, dlan@gentoo.org
Subject: Re: [PATCH v4 1/2] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for SOPHGO SG2042 SoC
Message-ID: <20250407140739.GA2174606-robh@kernel.org>
References: <20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com>
 <20250407-sfg-spi-v4-1-30ac949a1e35@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-sfg-spi-v4-1-30ac949a1e35@gmail.com>

On Mon, Apr 07, 2025 at 02:35:12PM +0800, Zixian Zeng wrote:
> add compatible property to include "sophgo,sg2042-spi" for
> the SOPHGO SG2042 SoC SPI Controller.
> 
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index bccd00a1ddd0ad92b437eed5b525a6ea1963db57..94102d94ed5dffe889a8a11c1c637d466713c208 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -88,6 +88,10 @@ properties:
>                - renesas,r9a06g032-spi # RZ/N1D
>                - renesas,r9a06g033-spi # RZ/N1S
>            - const: renesas,rzn1-spi   # RZ/N1
> +      - description: SOPHGO SG2042 SoC SPI Controller
> +        items:
> +          - const: sophgo,sg2042-spi
> +          - const: snps,dw-apb-ssi

This and all the other cases with snps,dw-apb-ssi fallback should be 
combined into 1 entry.

>        - description: T-HEAD TH1520 SoC SPI Controller
>          items:
>            - const: thead,th1520-spi
> 
> -- 
> 2.49.0
> 

