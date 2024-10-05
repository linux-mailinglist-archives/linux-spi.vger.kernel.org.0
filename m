Return-Path: <linux-spi+bounces-5109-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC19991423
	for <lists+linux-spi@lfdr.de>; Sat,  5 Oct 2024 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB9B1F24348
	for <lists+linux-spi@lfdr.de>; Sat,  5 Oct 2024 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6C231C96;
	Sat,  5 Oct 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5FsEwKQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCB20B22
	for <linux-spi@vger.kernel.org>; Sat,  5 Oct 2024 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099626; cv=none; b=SlG7TibW+37Bo65ILkcEIP30pMswuanPQuqMPsHM2Wr5gWUwsTsbWLrA95uLezfXPkAb2Bz3+kyZ2ilIlqvlnRqS0oCFWfFXb162ihto16N3jkMJuQLWOf44WoSdA3FOHStxIDQLLEpcfJ4UFHY28ASZ0/1brfp4G/JqJ7fhavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099626; c=relaxed/simple;
	bh=7Fy5YXfLDXoTky9WaUjTydBJ5g3CwngmUiQD+MC4j8o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kVMApwfy8uoHdQVYwGhrroJSV72B5Xqan5YxhRGbO0CMjnwm8jZmHuupvX0LbvV64drizhs2CAHhZOkVfbOiX1By1GKcNZ7s2brq1agtGFGVnu3IT+i0QTaSO5ghkaR1WbEWjn1iIhvENB1adQl9iigh33uAQ3XSrNK+I5C6OZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5FsEwKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2B0C4CEC2;
	Sat,  5 Oct 2024 03:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728099625;
	bh=7Fy5YXfLDXoTky9WaUjTydBJ5g3CwngmUiQD+MC4j8o=;
	h=Subject:From:Date:To:From;
	b=g5FsEwKQmDe+2oTco37cW/gKIHUKmx4QLmnOUPntEmjZ086znymuNHkPL5krli82Z
	 sZ/Zz6w5VMqpxkxlC2GC6dhh/1QlElhfJx4FMUoeVzJIeZVtsCZoYuorNYSedxWnHd
	 JR5vPPZWzFF/t7AB+wZRvc10gNm2w5ijJoejtR5zCHrYorZsOutq3wpj0qN5veK4Le
	 orsLwR9z8f7cdHHNUZES24aVckOJhGtcSknXeNOmbWc+SuqJpwkKG2lLE0yLg3PanE
	 nE/DTDEfbBSCqbXGLEXlZy1cjhkVLb2fDRamzHXW1MiKz7uAJ9xzrTggDSvKbCRoRA
	 KQHpAmTwf2K0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71DD73822EA2;
	Sat,  5 Oct 2024 03:40:30 +0000 (UTC)
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
 <172809962892.2985466.8553973105737373669.git-patchwork-summary@kernel.org>
Date: Sat, 05 Oct 2024 03:40:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Provide defer reason if getting irq during probe fails
  Submitter: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=895495
  Lore link: https://lore.kernel.org/r/20241004094234.268301-2-u.kleine-koenig@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



