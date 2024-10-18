Return-Path: <linux-spi+bounces-5254-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C29A4539
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 19:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3552881CA
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 17:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D8204958;
	Fri, 18 Oct 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpwYkfgU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50FC203710;
	Fri, 18 Oct 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273452; cv=none; b=E+P/Ad0aYxNlsq2Qo5KvihxTpu75HdBzPjR/bs7q3tdPC/FFflI8ayd1sSD9gw85bfJlfj8D4VBsokiC1tIrf256HX5ZF5ga/DG3DeA2utKm6J3wiXeCNyR0De9Vbs9XYINEcrhXaAVKIWXZr5/CvuGz7cFzD8ER5FxdrXwVBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273452; c=relaxed/simple;
	bh=BFKPAnzwdO1AH3rmZAFsqWn7POZbwr7tsMwaOi51JSY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gxlmgtYgDCNZJVnxB7mSFbteZvemsRsfV93FLjLXXECXPj4ztFwIcH82fR0OYFHcP1f99IS0eZPpCBEyv2sVel96MgmVBHfuWl14S1RhHboAbbiEih5XfYHlIq4vABOy56Rry2np1/7iENrksBIbO4MGjnvAumxF5pWlQM35lHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpwYkfgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4F1C4CEC5;
	Fri, 18 Oct 2024 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273451;
	bh=BFKPAnzwdO1AH3rmZAFsqWn7POZbwr7tsMwaOi51JSY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CpwYkfgUxqIYbqSESyYfyUtUqAZonfDMS3clSiMOMT30z2AACSed2Hx8SrHQa/NbT
	 jY4TD+OLpD1XsP5rb9+1IRi7EOanKh1TZbxcAyT1KjO6jej+nxf2A6tmM3NSpmDCZD
	 VotleVAj9w9NAr9hmb5sMPqX5TX2FElu+VwQFBvCG8N7n/YExNu650n7mXIIymJ2OA
	 h486EozrgFsX2wbd+TG7EuwQ3QwbfPIj8HK8KUu8Pemv24Lfgs4iNMgyjU+yLLDBZz
	 R0MhKBQEElR5qJlsnxLenRxgm40cyodRwSI5OqwSZz0VVOhD6x1gWKT0v8tTA+wc98
	 xF3SWhB5eEBeA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
 Anup <anupnewsmail@gmail.com>
In-Reply-To: <ZxEm-H-PjlQyXeOH@Emma>
References: <ZxEm-H-PjlQyXeOH@Emma>
Subject: Re: [PATCH v4] spi: dt-bindings: brcm,bcm2835-aux-spi: Convert to
 dtschema
Message-Id: <172927344849.163853.3041214371823345182.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 18:44:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 17 Oct 2024 15:02:16 +0000, Karan Sanghavi wrote:
> Convert bcm2835-aux-spi binding to Dt schema
> 
> Changes since v3:
>  - Updated the patch subject line
>  - Reformatted the description to fit within 80 characters
> 
> Changes since V2:
>  - Modified the Patch subject
>  - Removed unnecessary description and example
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: brcm,bcm2835-aux-spi: Convert to dtschema
      commit: 4de1cdb3c299bb98d70198c1fa20c71f0893835c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


