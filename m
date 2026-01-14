Return-Path: <linux-spi+bounces-12361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 098FDD1D53D
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 10:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5ABBF30024FF
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B943806C2;
	Wed, 14 Jan 2026 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWrvtQuh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331BA318BB2;
	Wed, 14 Jan 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381319; cv=none; b=Ak08bacv38L9PcYJ/OEVbpyXEwDSlvkB4tkZvz06F87XHSQ4xp9Wb48hexaBnqsRFV06Sw33+b3mfYU6AbGmlv4DEqVFebak7/GV53UlsfappLyvjI2Tiksd3ImO9TQEk3YRnUVybckGUoO+HfsgakTduf0N868K6KdANzQAKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381319; c=relaxed/simple;
	bh=nxA2mHonqKWViVIbRKfDmQdwUTDEjyfSyt+tTaVRFyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ/u6jSwASCvNFqnNnM0JqMckDG+gNLPIyR3T73dF/WKr0iXJCbAl/3pNQxOfYiHUP2eLuTdUQ7DRIfe2L6AL7BjLb70Xqt2Y6MDXIdhA2aaJpPe5PhdOjQXllOZeFDt7cE/CBUw1odEcYClYHU0mwRAH0FJ9mv2TAT4g3fVSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWrvtQuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A83C4CEF7;
	Wed, 14 Jan 2026 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768381318;
	bh=nxA2mHonqKWViVIbRKfDmQdwUTDEjyfSyt+tTaVRFyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWrvtQuha5kSY4m2qn8bt6qBPuPGzFC+vQm/GDyMhNzJXv55sIA9fZftUsGujQ5cc
	 XoLR36CW4UgIhf/ERZhC8WjtGVdrfN83Tj2dGHcXKNhoALS5UaOfeHxYqJCguGD31B
	 PTOk9b0BC46LSeUVb9tFxa0H0l/Zoi5MJGnF3jwh4Ynf1kQCzcTr8LZGuXy/G3yp+V
	 a6fNGXQJofUP/XJoBrX+eDUjoTZ4fMoaQy284HRq7yM0ziAH88hHnk835K6Ik0YXa4
	 ObAgpIfDsRpTVnM+7TrxZWs3IKIm+pVkwY2c3AWOHUDCfmMyhPDnjQmVbquWcXE7Wg
	 4Ab2gN1UWdKYw==
Date: Wed, 14 Jan 2026 10:01:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org, dmitry.baryshkov@oss.qualcomm.com, 
	andersson@kernel.org, bjorn.andersson@oss.qualcomm.com, 
	prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com, quic_vtanuku@quicinc.com, 
	aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com, 
	Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH v1 1/4] spi: dt-bindings: describe SA8255p
Message-ID: <20260114-tested-convivial-swallow-df674b@quoll>
References: <20260112190134.1526646-1-praveen.talari@oss.qualcomm.com>
 <20260112190134.1526646-2-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112190134.1526646-2-praveen.talari@oss.qualcomm.com>

On Tue, Jan 13, 2026 at 12:31:31AM +0530, Praveen Talari wrote:
> Add DT bindings for the QUP GENI SPI controller on sa8255p platform.
> 
> SA8255p platform abstracts resources such as clocks, interconnect and
> GPIO pins configuration in Firmware. SCMI power and perf protocols are
> utilized to request resource configurations.
> 
> SA8255p platform does not require the Serial Engine (SE) common properties
> as the SE firmware is loaded and managed by the TrustZone (TZ) secure
> environment.
> 
> Co-developed-by: Nikunj Kela <quic_nkela@quicinc.com>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  .../bindings/spi/qcom,sa8255p-geni-spi.yaml   | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


