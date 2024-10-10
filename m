Return-Path: <linux-spi+bounces-5201-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867A3998F10
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 19:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E4A288506
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 17:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D44319D083;
	Thu, 10 Oct 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr33LrPJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998019D064;
	Thu, 10 Oct 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583063; cv=none; b=XTEkuIv49ImHmQ3U0UQZDYYZMnspANVwdwoyB09UEBb6kiK+5oDv0Z1+n6D3wuzinGZMzUe8cCTTNkDfqwdNNbnBRtXKmOxLViEhtyMDs+PoCYe0Uo4OYN+NTsfYO2Lnc4dr7oNIIt0qpLvWfRs38rlfsI2osCpgUF/nCyDw7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583063; c=relaxed/simple;
	bh=LWqRgOJyjhmzC/oM31Wppo5HRgG6EO757vIU1WFMl3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy8v7LWlPhx8flJbwpr5w8/gSrzJfnRfPHhVnU67k3zHcSpmMa3zDVrDt2iNAryYODapb3hYjReDfgUDUHtguVljRN882q9kr6ch91TYf+DeW/kFu7X86FlXmpfEkalVGZC/s4w1fcEqnUkU/606Ii8IWxfR4teKqqkK19J9GEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr33LrPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A07C4CEC5;
	Thu, 10 Oct 2024 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583062;
	bh=LWqRgOJyjhmzC/oM31Wppo5HRgG6EO757vIU1WFMl3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nr33LrPJDjzXFmLgjgcyuwuiZux+fWPYa84/K3umfWTNtr/BiLgMyp2kv6SulKf6z
	 QYD6yZSPOdF7RYJoz8lB30GY6bVipdTSOCbW+m8tUNhNEjBljJ6pub8XJFr32XC/UK
	 uXWrrAyezHF+zyyoQZ1BQrfzmFXHi02Auz9LjBJf6YjRW7gGTlHkl6yW5n9ELjgxrI
	 nfe0x+qIlw6QHxg0ddwLxjqgw6Y5Zpa215VbotvGueMPziER0V0tO0QIlB/zlqMzlJ
	 CIvT4VI6xhnY31fdPqTHBkN0sw6m67c0K8/KlfVw6opktjcn5rtSiEWwzG9mFK1Q3V
	 w/4duq3lVF7qg==
Date: Thu, 10 Oct 2024 12:57:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com, esben@geanix.com,
	conor+dt@kernel.org, manivannan.sadhasivam@linaro.org,
	linux-kernel@vger.kernel.org, broonie@kernel.org,
	nikita.shubin@maquefel.me, linux-mtd@lists.infradead.org,
	vigneshr@ti.com, arnd@arndb.de, andersson@kernel.org,
	linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
	krzk+dt@kernel.org, konradybcio@kernel.org, richard@nod.at,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v11 1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
Message-ID: <172858304953.2090269.15996975253037715461.robh@kernel.org>
References: <20241010070510.1504250-1-quic_mdalam@quicinc.com>
 <20241010070510.1504250-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010070510.1504250-2-quic_mdalam@quicinc.com>


On Thu, 10 Oct 2024 12:35:03 +0530, Md Sadre Alam wrote:
> Document the QPIC-SPI-NAND flash controller present in the IPQ SoCs.
> It can work both in serial and parallel mode and supports typical
> SPI-NAND page cache operations.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v11]
> 
> * Dropped Reviewed-by tag
> * Added Soc based compitable "qcom,ipq9574-snand"
> 
> Change in [v10]
> 
> * No change
> 
> Change in [v9]
> 
> * No change
> 
> Change in [v8]
> 
> * No change
> 
> Change in [v7]
> 
> * No change
> 
> Change in [v6]
> 
> * No change
> 
> Change in [v5]
> 
> * No change
> 
> Change in [v4]
> 
> * Fix spelling mistake in HW description
> 
> * Added commit message
> 
> * Removed '|' from description
> 
> * Removed minItems in clock
> 
> * Added blank line
> 
> * Removed co-developed by
> 
> Change in [v3]
> 
> * Updated commit message, removed "dt-bindings" from commit
>   message
> 
> * Updated compatible name as file name
> 
> * Added hardware description
> 
> * Documented clock-name
> 
> * Moved dma-names property to top
> 
> * Droped unused label "qpic_nand"
> 
> * Fixed indentation in example dt node
> 
> Change in [v2]
> 
> * Added initial support for dt-bindings
> 
> Change in [v1]
> 
> * This patch was not included in [v1]
> 
>  .../bindings/spi/qcom,spi-qpic-snand.yaml     | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


