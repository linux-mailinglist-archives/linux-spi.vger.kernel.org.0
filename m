Return-Path: <linux-spi+bounces-4917-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241897E33F
	for <lists+linux-spi@lfdr.de>; Sun, 22 Sep 2024 22:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32DB2811A5
	for <lists+linux-spi@lfdr.de>; Sun, 22 Sep 2024 20:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F84CB2B;
	Sun, 22 Sep 2024 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiDvsu+9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274F39FCF;
	Sun, 22 Sep 2024 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727037137; cv=none; b=hpEZ/Nyj/nBYDX467xs/fuZ/CZdJvYWjDvhUzXMVDsQlRFq/Snw3Zk5lgSjOrOJcqWs2QJ8ksUCO07as2vcpsCjsPPmzRIo1e46FuCJ1N24UdElnYfR+MyWaueY+uAZDkjY2zyTP+2ds61c+u2ikWhZi2WPm33RYet1imUnfaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727037137; c=relaxed/simple;
	bh=Wkhxr7zFNFIazgoASlMplbrwcKNgSTWyidioOVkTuBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juD+eXtM6D8BR57WDVLC5tbteRxK/JKQkgkM85uqfPdKwpzSlYU5XEi5l5VNv/kh1ZiJwbfp/lXaej0kj35Ho1Qt8eLLz0bYPC7XhP/v8ErKZuVTKG+r+3pgRCS7iv0rUf9M+wWW8xjZD6NU+5Cb7WpC/ZHQyJPVDnPTeel9Q9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiDvsu+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88F6C4CEC3;
	Sun, 22 Sep 2024 20:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727037136;
	bh=Wkhxr7zFNFIazgoASlMplbrwcKNgSTWyidioOVkTuBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiDvsu+9gnBUH6LkeNAgFbvmb8NH/msjU0IY5ssA4B4yiyvdSIJOBNVt6vCf+X7YG
	 WJLbqLlUuc/Te1whGHFwEypeKUFrWs71Bh1+fpInwHV33FhGbpBUTX1jbQ35xmxPB+
	 TsRxgFFUXsyxhtsD6eQEYfuYmqPak4IBWdVMSgU0lQU2Heut0HrZPS2AbY6B2oADnt
	 7YwYx+QHfAM1IuTPAuwvjZfHbrt35b0tjZFzqpVzv1x1X4eQoeWM2AhxApYf44d4B0
	 L8HdmiZEjiRvmc7YWNKlO/6nxa1GF/orW/YVi89RdHNyHrLYhQPcExR94FdWMG1Ya0
	 aq9rHAbK56XIg==
Date: Sun, 22 Sep 2024 22:32:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	manivannan.sadhasivam@linaro.org, vkoul@kernel.org, nikita.shubin@maquefel.me, esben@geanix.com, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH v10 1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
Message-ID: <k3id2ywyghhmoiekehko7ear2nef5ygmizvkax5s6sdi2zhn5d@yfhgl5xte4dw>
References: <20240922113351.2390195-1-quic_mdalam@quicinc.com>
 <20240922113351.2390195-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240922113351.2390195-2-quic_mdalam@quicinc.com>

On Sun, Sep 22, 2024 at 05:03:44PM +0530, Md Sadre Alam wrote:
> Document the QPIC-SPI-NAND flash controller present in the IPQ SoCs.
> It can work both in serial and parallel mode and supports typical
> SPI-NAND page cache operations.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v10]
> 
> * No change

...

> +title: Qualcomm QPIC NAND controller
> +
> +maintainers:
> +  - Md sadre Alam <quic_mdalam@quicinc.com>
> +
> +description:
> +  The QCOM QPIC-SPI-NAND flash controller is an extended version of
> +  the QCOM QPIC NAND flash controller. It can work both in serial
> +  and parallel mode. It supports typical SPI-NAND page cache
> +  operations in single, dual or quad IO mode with pipelined ECC
> +  encoding/decoding using the QPIC ECC HW engine.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,spi-qpic-snand

Recently it turned out that Qualcomm generic compatibles are not
generic... That was odd, but to me it is a clear signal that something
should not be called generic if it is not generic enough.

Please switch to soc-specific compatibles (and drop my reviewed-by, so
this will appear in my review queue).

Best regards,
Krzysztof


