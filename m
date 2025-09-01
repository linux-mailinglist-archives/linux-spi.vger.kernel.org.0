Return-Path: <linux-spi+bounces-9839-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCBB3F100
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 00:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367D11B21112
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 22:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6C283FCE;
	Mon,  1 Sep 2025 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/jzdxub"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B892CCDB;
	Mon,  1 Sep 2025 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756765637; cv=none; b=HRj5Ej711te/PBjmkXnaYSIsMAReYfa9vTi5iT7HYO/KR/jJjl8n6nn0TtmEsmW2WamNTGC32NIFL6deWBYngR7T+6tBsMrhpH29DdXVPRa9NkZI/nkEa/6/zaz/jaxgqtEb9Lq5+c+W5SV9qEC4V4RcdGWvt2HLk9iloeBzuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756765637; c=relaxed/simple;
	bh=ES7XTBVdBjn5qMWK9aBFun/HPqY4R9a82L02uT3WVw8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oAPB41+Q1Md78g1XL+b5kc1VEchw1LxQMCz595CANfHrULxjcpWWAF0hVUcFRuaK+KF4PJ74GjxQm8JNYSG0KxYPTgedSrjPGlPgEswm+PM2m7zb5Pu62xM6aico80tE5XEpm3XSZ6T/F0yNTuETlnOV+Yjg6m+QW7lbSWfXR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/jzdxub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8488C4CEF0;
	Mon,  1 Sep 2025 22:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756765637;
	bh=ES7XTBVdBjn5qMWK9aBFun/HPqY4R9a82L02uT3WVw8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=e/jzdxubLo3M5U2dnCo3IXbSAFjo3qTzdHBaTn6v64OlC3Y88hb8xpyAIaJhvAQeE
	 kEpo9QXNZ2k5m26VzjJK31IARqH/LPywvNfGEiyMw0MGLqk4CC8V2VcviBnXkgIRRu
	 wCFpjUPG0ho7/FeNZRm4HL91mgC43o4USg2MNmwh44cI4kVh2aiP4j+6iBW/qpQbR2
	 AvYsDW8Lu0CaeBtQHYaifD2IqccEH+7kHi6zHPbgjtwBc58PMW/SvMhJuHs+Z9D0f6
	 wKGkjBmiA/4iTMZA5w78kvgxwAc39kR67WAjOCFRRZ/H7eddU4wflyyaW4kkPmkdhX
	 qpIG3NpWzkSbQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Niravkumar L Rabara <nirav.rabara@altera.com>, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>
In-Reply-To: <8704fd6bd2ff4d37bba4a0eacf5eba3ba001079e.1756168074.git.khairul.anuar.romli@altera.com>
References: <8704fd6bd2ff4d37bba4a0eacf5eba3ba001079e.1756168074.git.khairul.anuar.romli@altera.com>
Subject: Re: [PATCH v3 1/1] spi: cadence-quadspi: Implement refcount to
 handle unbind during busy
Message-Id: <175676563542.906617.4450367813883915988.b4-ty@kernel.org>
Date: Mon, 01 Sep 2025 23:27:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 26 Aug 2025 08:33:58 +0800, Khairul Anuar Romli wrote:
> driver support indirect read and indirect write operation with
> assumption no force device removal(unbind) operation. However
> force device removal(removal) is still available to root superuser.
> 
> Unbinding driver during operation causes kernel crash. This changes
> ensure driver able to handle such operation for indirect read and
> indirect write by implementing refcount to track attached devices
> to the controller and gracefully wait and until attached devices
> remove operation completed before proceed with removal operation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Implement refcount to handle unbind during busy
      commit: 7446284023e8ef694fb392348185349c773eefb3

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


