Return-Path: <linux-spi+bounces-2747-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D948BC500
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 03:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1BAB20D43
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 01:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5D3D966;
	Mon,  6 May 2024 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfBnnt/7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B43D552;
	Mon,  6 May 2024 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957494; cv=none; b=huuFUR2V/r4N7hhFlnOdZRdf108YiMRDH751MuxJJxAAGkJO0MkuZCiFKfjL4LzJNDXhe323uQCCJR1+2d2a7wiTYH99z9FyDWYwkw6RkIKoM3T5DFzfK7cfoF1x48a0hUZhoXfoXN89POim3dxRvSc79rQ0DNEAsE/Sbs8THzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957494; c=relaxed/simple;
	bh=tti+fiLKmfUZl9lYetJIhk/gNjkYaa/S1GXTuQDiWw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qo/Gr4vK6iRl0Tw+sfRXQ0M9HFvBrOvk44UuWv7inkjX2Fa21SiEHAcpYyzJV6W/etlUp5fpfGPLon4cZ5fAqSYDa1RZeGFemTrG0ioppemntbHHhrvElnhlRrFtw+Y36gv0P4sP53SOkVbybWzqQjufqfX3ebht6XzmBK66fPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfBnnt/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2D0C113CC;
	Mon,  6 May 2024 01:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714957494;
	bh=tti+fiLKmfUZl9lYetJIhk/gNjkYaa/S1GXTuQDiWw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BfBnnt/7+gsLwYJ4FyCR/N8mnmesKhivV6LqwnjYF2NW0z6dP+d/C2Cvzga5O5TPO
	 qUs7eeE+8ZhXcHcrDZnmqXKmpz74x7BpETQoiyE6iOyhp+9huW1q3Axh/NWhXQOTao
	 qvtk9aq9e5B6O1ToDSaLdIxYQSmaQINHVchkN/QAcHRZb1/c8///RjO/ES/xE8XBvu
	 8MFtHUWnHyYN8JVOOiXIiW1ZG7QoINTXPmGfvuw9N2Tw1t+KqWZ6YCtZlmKfFqMaUv
	 VORd0ztYkeamHpiTHmQDo6eboEMdZ+HVZ8KR7RNMGf6kJt0vVHcYIBy/HefnauoTbM
	 RpG7Hpn+O/2IQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kousik Sanagavarapu <five231003@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240501165203.13763-1-five231003@gmail.com>
References: <20240501165203.13763-1-five231003@gmail.com>
Subject: Re: [PATCH v3] spi: dt-bindings: ti,qspi: convert to dtschema
Message-Id: <171495749247.1941246.17606356697412087389.b4-ty@kernel.org>
Date: Mon, 06 May 2024 10:04:52 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 01 May 2024 22:18:53 +0530, Kousik Sanagavarapu wrote:
> Convert txt binding of TI's qspi controller (found on their omap SoCs) to
> dtschema to allow for validation.
> 
> The changes, w.r.t. the original txt binding, are:
> 
> - Introduce "clocks" and "clock-names" which was never mentioned.
> - Reflect that "ti,hwmods" is deprecated and is not a "required"
>   property anymore.
> - Introduce "num-cs" which allows for setting the number of chip
>   selects.
> - Drop "qspi_ctrlmod".
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: ti,qspi: convert to dtschema
      commit: c24d340598ed535d3bb6f5e64c544cad4ab2b67b

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


