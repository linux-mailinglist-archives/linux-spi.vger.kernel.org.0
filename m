Return-Path: <linux-spi+bounces-3753-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5390D927E0C
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DB81F242BD
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F613C905;
	Thu,  4 Jul 2024 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgZtqB/+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF762F23;
	Thu,  4 Jul 2024 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123142; cv=none; b=GzB0u2cFSVvjyTXTmHZWK2kQ1zmM+7kbEDDC10vXyIBxexRCQI8Qk+dxP9QsK3GklbROcpK3URmuSezdb6h6ZaiD90+VHP0uS2RtZGgBR8t+YS8lEFkbqWky6Ahabu+o0nciXm3iizak+oF7PMt8ySU5aNnCRMSNa6mWg1a3QsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123142; c=relaxed/simple;
	bh=apep1Q9DkKcZcxF/SQGxA71cyB/fMtchWOgXl4gMPCI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bs+5HOp0dhGJ27RbVcjiSUB9Ac2quNKXDbdnEWY5FpZ8dudTPYIb9h9Jwz++8BOYaIYmQMdkYFc61LFwY1UnqcPU5kMcI3oepj4jCYWDXpl4JjuPG81w+xs/HMbWNzakS65lSaiugQXMHV2jQS3ZIEgvOzSQfYdo2iynbRBJXh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgZtqB/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5753C32786;
	Thu,  4 Jul 2024 19:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720123142;
	bh=apep1Q9DkKcZcxF/SQGxA71cyB/fMtchWOgXl4gMPCI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VgZtqB/+5P+OjYEvPtgheKZWolSMXxKZWcg9HO7e8CR8b7vnqdKYmVisOx9Hs2IM/
	 XsPucPIjUYAhGwCzLyVHhlJJKZwbto+uh9hR40DKnS+GgqIn3eoaqudoFHuth+Mgq2
	 PSNeUKTTRN5tM8Cgpa1zCL7nyBHa3NEImB5Wsk8pnlMrXx3jN2XtuUMU0xI0n0zyYm
	 wq5ANihj2CqsfY/yusmYU4MAHEXcWwKeJ7izuXExTZ+HCoSF8oY8kFkMkT+zlJUphS
	 yS4YYGwTfdeyP3CA/zbzrvwFZfu576gKowNTWnRX3mTh1BOMaADvqLHFL+kBtXsn4j
	 AodR+ELyIeNPg==
From: Mark Brown <broonie@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Colin Foster <colin.foster@in-advantage.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240704-spi-revert-omap2-multi-v1-1-69357ef13fdc@kernel.org>
References: <20240704-spi-revert-omap2-multi-v1-1-69357ef13fdc@kernel.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Revert multi mode support
Message-Id: <172012314050.120154.11791655671608343293.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 20:59:00 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 04 Jul 2024 13:05:48 +0100, Mark Brown wrote:
> There have been multiple reports that the multi-mode support in the
> OMAP2 McSPI driver has caused regressions on existing systems.  There's
> been some discussion and some proposed changes but nothing that's been
> tested by all the reporters.  Drop the patch for v6.10, hopefully we can
> get to the bottom of the issue and reenable the feature for v6.11.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Revert multi mode support
      commit: 8221545c440b5f83f00b3e5a92bbc86bf268bad4

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


