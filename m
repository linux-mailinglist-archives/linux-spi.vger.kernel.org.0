Return-Path: <linux-spi+bounces-9178-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95221B11493
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 01:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25429AC0AB6
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400F243946;
	Thu, 24 Jul 2025 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZXItp+O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421CD243364;
	Thu, 24 Jul 2025 23:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400054; cv=none; b=L+MOYKTfpZcp0K2Lf2KFT5LyoU+46dQPp0+4esX+EtDIjPk3fg4Megt7GCcv23OEOzPqYBFcQP/JAU6xn3WHwCTSRs0dtDpiOXa2Jf9yIc8a0+6mgQsIGlUf2ZdwoQR9XDWljRxi9BnNzQtdSxpRzECYpi2th5hgFbDqoYYdUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400054; c=relaxed/simple;
	bh=X17ZBuWwMErqQ/EgVoS7dWb3Cs7Yns8iRBMnXLwlr6w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=azDlGTa0WcrItRB3YUTCNHW/+PjkbPhg+i/mO3JOqVyYd0aTPzeJQWauWX25nT4rK/O4wOmLd+iYUudstleO1qJtiXWbPMqAFn8QOVMKBoPM/qVds6vKEJ0+v1m8AyNXjC6eiDEZ9VWlpJWIXSO8D9G+//+Eot4Iqg4IiSuyTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZXItp+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A58FC4CEED;
	Thu, 24 Jul 2025 23:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753400053;
	bh=X17ZBuWwMErqQ/EgVoS7dWb3Cs7Yns8iRBMnXLwlr6w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JZXItp+OZz1+v6vlrYtxhvnrYW3ao7ef1GOxby6BBLsr/xsbFs70tKOqsNR2NkX3t
	 ngf//180waByjoafyt1ye7b7JlwLmib/ofEdEEpmkWXPMKi8kkLrgYM2/oxlIkSd1h
	 Ci1htiV1ZoFg+PGNv8Q5UlXnF3hfByjZNheA0t9hFYHEvQCIiBOtrVVvdfa57Ao5g4
	 fX0Gn7t6SfZHQkYEDpBbOvmI2+wy1fKTA9mKYNjpRdw+FQCAYOeueTl0G/PBgXluSn
	 f/ks4VzHxAOOqifBLlDeemCPSkx+uYAKci9reP/2V07VxGnWzc9h06DCRwFwSVZjlF
	 R91SVMIKxXFYQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250704162036.468765-1-fabrizio.castro.jz@renesas.com>
References: <20250704162036.468765-1-fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v2 0/3] Add RSPI support for RZ/V2H
Message-Id: <175340005103.192002.4970048454076941668.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 00:34:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 04 Jul 2025 17:20:33 +0100, Fabrizio Castro wrote:
> This series adds support for the Renesas RZ/V2H RSPI IP.
> 
> Cheers,
> Fab
> 
> v1->v2:
> * Addressed build error reported by the kernel test robot.
> * Addressed comments from Biju in driver patch.
> * Addressed comments from Mark in driver patch.
> * The clock patch has been accepted, therefore it's not been included
>   in this version.
> * The defconfig patch has been accepted (pending acceptance of the
>   driver), therefore it's not been included in this version.
> * The device tree patch has been accepted (pending acceptance of
>   the dt-bindings patch), therefore it's not been included in this
>   version.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: Document the RZ/V2H(P) RSPI
      commit: 44b91d61c505863b8ae90b7094aee5ca0dce808f
[2/3] spi: Add driver for the RZ/V2H(P) RSPI IP
      commit: 8b61c8919dff080d83415523cd68f2fef03ccfc7
[3/3] MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
      (no commit info)

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


