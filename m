Return-Path: <linux-spi+bounces-1703-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBD48755B4
	for <lists+linux-spi@lfdr.de>; Thu,  7 Mar 2024 19:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5AFB24F90
	for <lists+linux-spi@lfdr.de>; Thu,  7 Mar 2024 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F78130AE3;
	Thu,  7 Mar 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbtzLx+E"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED2130ADF
	for <linux-spi@vger.kernel.org>; Thu,  7 Mar 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834429; cv=none; b=OOGNG+5I7cYB1TfUoduoXK5tt39F0N0NmV4iHLE+SJUT9EEvhS6HDLqP+RzF/LPCbNXgVmQgKpAdEwgx4aVLGwiFZKwguzRptNYA/+HLBZsRbtGzD2AVSwUFKpDdBeQ4WONwFuzt4fSH0QY3AIkQ66IRxtNpjZKo32OkFcso4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834429; c=relaxed/simple;
	bh=BfOd7U0iHHYZ4bMQ66wK483GAJXu4bwAZ9wIYpkWSy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Ce8B/kzOYyJsBI0SnQQfqNUlIvDv5btV/7j0VjrCjcU/xnBlx9lrCu4a6G9JIwyJos/tV/mtT46AN2awLBlasAYJp3fTmNaAXfbhEmt0pO5wKW7s7anxQiiGyXLF4cBwXGwSEivkMYAkkXgqxtmeQUxWledHxTDsjEIfzIIK8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbtzLx+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52D3FC433C7;
	Thu,  7 Mar 2024 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709834429;
	bh=BfOd7U0iHHYZ4bMQ66wK483GAJXu4bwAZ9wIYpkWSy8=;
	h=Subject:From:Date:To:From;
	b=sbtzLx+E0wAz7CArjBhtNNeSGiArOKLz/G1C/A6SraAhuJ1GflSI7CgJbccgYcHaP
	 gLndmweAet3zNOvrmXD/3TRt/w/sR6QgXXmga7X7qj68iSiaN781Iwoo/fpd42EP3r
	 EHxwJQQjlKlNKf6+s4IyqT4BHRwj/v9pnxnvoLPG7UHA3KGU7lcdZNfTFWF9pGHC2A
	 ciTPoHrMmqkN1y7ROXNfzeNtjLVliv7ox5ZccrCKV4pQrM2bHoHC78dV/0DNCbQziG
	 i43KOfwXhSyrd7JBaus5iEm+EHMHqgijen7JG324Dk18SZJMER7HR1XH0WyGxb7iNo
	 JVT67Khv40a9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2109CC04D3F;
	Thu,  7 Mar 2024 18:00:29 +0000 (UTC)
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
 <170983442908.3612.3498634022361819676.git-patchwork-summary@kernel.org>
Date: Thu, 07 Mar 2024 18:00:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Add more consistency to CS handle
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=833442
  Lore link: https://lore.kernel.org/r/20240307150256.3789138-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/3] spi: Consistently use BIT for cs_index_mask
             [v1,2/3] spi: Fix types of the last chip select storage variables
             [v1,3/3] spi: Introduce SPI_INVALID_CS and is_valid_cs()


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



