Return-Path: <linux-spi+bounces-6883-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7BBA3E771
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 23:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2D19C3827
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50E026738D;
	Thu, 20 Feb 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK5xDA+8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824E266F1D;
	Thu, 20 Feb 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090085; cv=none; b=tqoh+UXkOCEje1vpx+bbie+S/8pdWL00KkBHvSW8jZ2+APnvHQb7uizMGWI6BEii7+p6n9Rufw4mQptqd6+or8ZEwGHNsCpqTcV/jnJmVFrkG+OCIjTXQhnqKc6wyr1cE6KImcvpjQvEFFmPfN8JpEDo18LKeDMSeAcDw05Aq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090085; c=relaxed/simple;
	bh=zbNXVuTI6mbjIQeoZSBtFo9TA3uSX1SrbRnfFkQ2RCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cB5WwLx5/cWbgFPZA7VnvSRcnVDbHGlNBnO+GZy4YzuQLmLCllXhgFTrCLIZeXWCcr2gvIByqAMnMvcyH7ms824fQkyn9mzhRme4jVkdqg1KGGVtqpJ/g0uXZiagH1pBE1bacxIvv+xgJQha9/JYEl8uvbPeLFhh9PN7ONb9pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK5xDA+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9C9C4CED1;
	Thu, 20 Feb 2025 22:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090085;
	bh=zbNXVuTI6mbjIQeoZSBtFo9TA3uSX1SrbRnfFkQ2RCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jK5xDA+8ot0Dd6uczig1y/B15n+S/ITuUq5KSTNB1Du11O6oMSDrtPwDhH7uRCMxr
	 4UGQ0LPbyvaaTXr2C8aSWsSf4FW5L4sw0UxCXnePt0z5G0uWGI7+0FxOvO2ltDZxWj
	 0esECf8bkZERXHSVaAiRThGQPgAslam3cr75uOXqmwknnQf4uDHvPiDPQzThT0JELW
	 CwiJnsyswiTlbxcHnCdBID3QddkafsRQX260vIR2ouHJbfdkNJNA16y+BcgZixRyjZ
	 h24JyUosLRtpnwaHwGQFJkDw/fzHIGwGy2Vykc95mwQEnxKGY35Cn01QBEZ5Y27cJk
	 bIiwfgQSuQRew==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250220-ppcyaml-spi-v3-1-e340613c7875@posteo.net>
References: <20250220-ppcyaml-spi-v3-1-e340613c7875@posteo.net>
Subject: Re: [PATCH v3] dt-bindings: spi: Convert Freescale SPI bindings to
 YAML
Message-Id: <174009008319.2293629.4152742389838123835.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 22:21:23 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-42535

On Thu, 20 Feb 2025 13:46:32 +0100, J. Neuschäfer wrote:
> fsl-spi.txt contains the bindings for the fsl,spi and fsl,espi
> contollers. Convert them to YAML.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: Convert Freescale SPI bindings to YAML
      commit: f3bfa0f07976a7996b6dedba21d2e0d164f08ce8

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


