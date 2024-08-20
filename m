Return-Path: <linux-spi+bounces-4257-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632D9587EF
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 15:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021B7B23D81
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354F191F67;
	Tue, 20 Aug 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdlDxuty"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4219069B;
	Tue, 20 Aug 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160454; cv=none; b=iUznMTTMeJFQmDu9KW7+E1eqySwWGS41rxhFhJ6oNvd6Yg8eoEpZwy9a82KYw5TSdu9v4BnYG/T/pDZRYQf81xE4WS1W9sRnO40KSwk5f8J1MU3BMchlPjWJfUJfA3l06wPmfhtToFtQDugaBNyY4fGSTz0/8L1gvfjj1U5a06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160454; c=relaxed/simple;
	bh=TmL2MG6tmktlS4gazMIIYv83XVcxiJAI3n8m4T7qgtQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QAfBITkbiP354M6OW3EPDLkiaM3ySRzIarK5SXOVHEQa24xjK2hGpBoj9snj8yH2N+8Bl6rfTZpNDPxijRiuUWRhxsdTowtHOnYKbNdB3RuRFB9jGksxX01JVJeaSzB6x16t9hOnWoaIduQbtPoGMYnlCapNb48vklD8qyMsjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdlDxuty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EAAC4AF11;
	Tue, 20 Aug 2024 13:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724160453;
	bh=TmL2MG6tmktlS4gazMIIYv83XVcxiJAI3n8m4T7qgtQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cdlDxutyjUdy1gXyrUez9ewxq1fj2UkFBChFSmKBYgpZzolck1GlPBwLYM+AWJNEW
	 tRwc+lQUDwr10qYVv9NYflXImncTeXAmeFCXBGOWvdcnvpK/I76hOvPi/n27zM0ck8
	 E+OTvDhlsYgKmUabDW+ZcflxSnE9kV39d3tJ4MVnEXEj0CdyYVsvxXfD0MpJSQ+str
	 NaO9cH2tCJ0t8237uPyOYD8ydVWVV/zL6U2xTFACek+QYr3l3tl8dlxpEBpq9nuFOn
	 4deiE+VzCy+WCow7xYBwZROZolpeNuwXFMIE4LUCHHAf4XHHBOiF1dIbGS/qsDkM7O
	 7kyqtbFk3j4vQ==
From: Mark Brown <broonie@kernel.org>
To: carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev
In-Reply-To: <20240820070658.672127-1-carlos.song@nxp.com>
References: <20240820070658.672127-1-carlos.song@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: limit PRESCALE bit in TCR register
Message-Id: <172416045279.160388.12340685060459162773.b4-ty@kernel.org>
Date: Tue, 20 Aug 2024 14:27:32 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 20 Aug 2024 15:06:58 +0800, carlos.song@nxp.com wrote:
> Referring to the errata ERR051608 of I.MX93, LPSPI TCR[PRESCALE]
> can only be configured to be 0 or 1, other values are not valid
> and will cause LPSPI to not work.
> 
> Add the prescale limitation for LPSPI in I.MX93. Other platforms
> are not affected.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: limit PRESCALE bit in TCR register
      commit: 783bf5d09f86b9736605f3e01a3472e55ef98ff8

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


