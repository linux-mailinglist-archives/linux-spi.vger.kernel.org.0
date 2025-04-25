Return-Path: <linux-spi+bounces-7769-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51711A9D3FB
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A1B4E23F3
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99364222599;
	Fri, 25 Apr 2025 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWODcmFX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D831B414B;
	Fri, 25 Apr 2025 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615618; cv=none; b=lS5ClwElApSgD+4ueDgQn3tWvYvp5JBgM4WDjAc3LnZ9whIBM1rnFECysLB1kg6boLtOQFOJoYst/HaicrELj4VpptZBCIlEYtZTex4t2mtY6gJl4lJ8Fn/wwG78B/TbgYmUo3hQumKQ2Cww0i6uJ/0Ij4mDv8I2XPCz5xB1WDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615618; c=relaxed/simple;
	bh=GIP+JmKsDq1yXJB9cilTTsWdJEXeurxdE+/HL3zld/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pIJ4avy/EfPpJL6LnikxCMIQlKGmk2XPG57CwFNHBHJbq63V8OC3oUxcaA+0andG8Q6OdV2VyR13meshDXEkD2AFcVlHpNirw/7vY7bc5dpqAKUwbHn1NGZk6QxtlaPBKysCBqd6Zi6IwuLwk4+py6PN69nGY4CynnplQD10q4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWODcmFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F195C4CEE4;
	Fri, 25 Apr 2025 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745615617;
	bh=GIP+JmKsDq1yXJB9cilTTsWdJEXeurxdE+/HL3zld/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PWODcmFXsj8MovENvqkwg1hQfAYLkvq1lQpV5/cE8YabCtAlCAUO7KbeWVJTg2c4d
	 0YV21hKqcZzdOYMbkNYX1xPHbGPWOZ6GgR6rm9c3rF2y/86Y6L7nsrkn1SkWE37ng9
	 o3TJaEB6KMlAkd2KdGmaI36KAaHLALqikZCIx4mkYX5AXjic0zAIoE2o5Zv9HO0AGa
	 LTzATgLzY2GGzGEWIyg2VLWPvCzVt1LHJHvZZGL5v2hE5Hi5NEne6X9R2d1D8T6zGk
	 aLsPw6z1S3dZh+MmsKJfo3A8dWqlN3uowoWUaI4pCPdJkRrMiWmZ4oPVX8gwY6XVtA
	 PNoNwQJoveXjg==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-spi@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250424-qpic-snand-remove-wlen-v1-1-2a7467ce2e3a@gmail.com>
References: <20250424-qpic-snand-remove-wlen-v1-1-2a7467ce2e3a@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: remove unused 'wlen' member of
 'struct qpic_spi_nand'
Message-Id: <174561561639.278558.2940962492116902835.b4-ty@kernel.org>
Date: Fri, 25 Apr 2025 22:13:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 24 Apr 2025 20:10:59 +0200, Gabor Juhos wrote:
> The 'wlen' member of the qpic_spi_nand structure is never used in the
> code so remove that.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: remove unused 'wlen' member of 'struct qpic_spi_nand'
      commit: 64c05a1d66193b3a40ad1f29c3d8ba5483e4e0dc

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


