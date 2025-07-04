Return-Path: <linux-spi+bounces-9046-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D697CAF93BD
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09771CC0D1B
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B067C2D9EE5;
	Fri,  4 Jul 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P84e4cXk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0562D9488
	for <linux-spi@vger.kernel.org>; Fri,  4 Jul 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634581; cv=none; b=lnXRKiCGvqoxsZYJgDeD6Vb7O7B3ai4MVkmv959230YUdPyvz4fbwTDzX+6JNtPetbPp3wsgWXgSw8nsWOxKFC/cpcDKNhA80AD1cYIdA1yddpVNEHFTTFqvVV9+zlWtmk6BJ5DeGqtwQrH8zJvsEFcg+pkucn6kKbKWufON4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634581; c=relaxed/simple;
	bh=MHzllX1X7LNFasPomvNhotkZKzgykCjdQiWrAMmTsts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=S5TmVyJA1DKUO9yBAtfRnoTQb2+Bup93nq0YhT47CmU269gwgg3kVLMnZPhBKBqYXtFEglpSuH/ZvmBfV/MPCdQia8iG6F3ksa8JqVRztRAi7b75OgGSRJ4+i7W8tPqVLbedAJOiqUWcQmARvMrGmohdpQdMd9qmE20IPkOWdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P84e4cXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B17BC4CEE3;
	Fri,  4 Jul 2025 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634581;
	bh=MHzllX1X7LNFasPomvNhotkZKzgykCjdQiWrAMmTsts=;
	h=Subject:From:Date:To:From;
	b=P84e4cXk1NyVebL0HfBjP8mkhl8stSuBCgaLxTpxL95+acCwY9gsxXp26Jn/YC8kK
	 QuSFfvlCIZ6dT7AR/Z91WeSnK6lC1iA3wP1kKu4akZ6mQgqes7Otidnn3oB/oQ79zw
	 QugjgzDYL8WwGY/mbyoVc40ztfDMhnDVpFJnCfrrbaOYwomo87HPt/WPZQN5oEnsdi
	 iHZSv8snXeKaVWdUY15GuM+1aLLv3m4YcFOE/fhunESNO3/jxipwcDOlnX+FJna6qo
	 z2qJ2CL/g+WUMnRtKmW8Ike0oc3d/rbcFyS5fQajnk1veNGEA1SowFfikE81L52L9K
	 mvi9o08sjpESg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 750B4383BA01;
	Fri,  4 Jul 2025 13:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <175163460521.2208094.14386470335041954877.git-patchwork-summary@kernel.org>
Date: Fri, 04 Jul 2025 13:10:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-qpic-snand: enable 8 bits ECC strength support
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=978209
  Lore link: https://lore.kernel.org/r/20250702-qpic-snand-8bit-ecc-v2-0-ae2c17a30bb7@gmail.com
    Patches: [v2,1/2] mtd: nand: qpic-common: add defines for ECC_MODE values
             [v2,2/2] spi: spi-qpic-snand: add support for 8 bits ECC strength


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



