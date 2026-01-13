Return-Path: <linux-spi+bounces-12333-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0CD19494
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9991C300A1C1
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E739A392815;
	Tue, 13 Jan 2026 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcXcnIeI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506A349B19;
	Tue, 13 Jan 2026 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312934; cv=none; b=PH/aMKtM8rAGbkrhK1ls920Kd0SO+5wg/vPZ654GN2dmDL+jmM8toHxU5c5Spa/xIbwJieDGwLGXXKPP9qz+eNrQUsbu5nYde2sOmcfxLxuwHI7iROua/Y5gmaH8KLD6V8teD5p2artTxkIWwt6kNReZ+CxogJ/Fuud7PJL3oeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312934; c=relaxed/simple;
	bh=oNGLDlDLasVRtKItmSPWFuUPzymr5T3/0GPoMSDfHro=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ESaRrpqFiU2LOaQZOk+x9DZ08BtHGGIRptc4G4cv0pxWUQn5NRUSiPGridiceE951KkvgpjFkUbx1mVFq6o8VAbrz7hW/r0ERj2IzRwr1Z3Wk3fz77Capq7i/369UVXuW1k2GE0UqiKYcWr2s4nYfpuMZspCIAFNhP8qu/Jhppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcXcnIeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF86AC116C6;
	Tue, 13 Jan 2026 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312934;
	bh=oNGLDlDLasVRtKItmSPWFuUPzymr5T3/0GPoMSDfHro=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fcXcnIeIQ9Yvrjh+ylYnvQkJVRQADwmLAXSHQGoYAWTZq/TrjtQd4dx72DNgitvtQ
	 0sDSfGl3DhmazNzlKKP6SmmgpVTuhHAUIO6WZcBVx955U8VMg2B5Ff1W9kjfqCw+ai
	 GJCSNsfBO1LtASX5NECGrpxbDzqa1XzgZ6ybYX7honLJeUSMvIHBDSpHGKn/rzxQ8g
	 YjR4cCUqE19f3ZI8wW2G03FNRJSN+6rH1LuIAD3VJXj6J7/Ix3GMQPai9yN6CN973L
	 ICZzJcZcl1fTq7HscJ7Z6rjOh8kLWXjDp8NuJ4f+89EdDbHho3qMqpCPe+ffceLlY+
	 fRW2yP5HbqzWw==
From: Mark Brown <broonie@kernel.org>
To: Eddie James <eajames@linux.ibm.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251224110240.56803-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251224110240.56803-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] spi: fsi: Simplify with scoped for each OF child loop
Message-Id: <176831293365.74644.2519567291360760156.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 14:02:13 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 24 Dec 2025 12:02:41 +0100, Krzysztof Kozlowski wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: Simplify with scoped for each OF child loop
      commit: a014c203b54d9013ad52ad8a531cf46e71028f2b

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


