Return-Path: <linux-spi+bounces-1512-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6748680CE
	for <lists+linux-spi@lfdr.de>; Mon, 26 Feb 2024 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9411F2B11E
	for <lists+linux-spi@lfdr.de>; Mon, 26 Feb 2024 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC8812FF67;
	Mon, 26 Feb 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLe8Vyvs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3212F39C
	for <linux-spi@vger.kernel.org>; Mon, 26 Feb 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975230; cv=none; b=e1yOmIYnqtC9qfEy457QyJ56u25PwfbD7CsLCq1lepUkstu5hL7Heqcyh1ki+egMyhj0Et2/pNILIj7tb/uz6S+vTkZyQkqRNtmVyK8mBXp7lKCW17FQup3IpSNgmQVXq0B76Veie0hbInN8X/A7JnbE36KfKkWMczEDR1zojxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975230; c=relaxed/simple;
	bh=B9prQgiXn2jHTdxQPZ4ynZZTu80snSYaqV97kORJ8ug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KjpUfBzYzzoy/cO8b/cxBBQ/5e4VXcvrNzyjhO4UD20F4a1qqOkDoQahXrpzXNtPjL/pYBDUO5YuFh+nf8eWKp5hsBY8tjJ/bLuQeL3FVVk82PHTYzatZs4xZbS9taGds0rL+PdtGBwO0nadJlVLN8PPtQVITLzeyqrkCWGP3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLe8Vyvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B507C433F1;
	Mon, 26 Feb 2024 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975230;
	bh=B9prQgiXn2jHTdxQPZ4ynZZTu80snSYaqV97kORJ8ug=;
	h=Subject:From:Date:To:From;
	b=KLe8VyvsmA3cy80H4OTiI7YUQZZpGap3TpmAWoxDKrE7FDE8XI8C/+8QQWSKYHwQD
	 tSWBTdQL3HmuLQIDhNPAqe8HglfhYrjxMkds9b1ZB8MblT2u0vJoNLGPQivowYkoVE
	 /eJyx65ErkAMt59UkT+H5MV02prAFcv65qxOKzFBRGBPKXr9FkYhIhLt1pm/TAfe+o
	 947lSHlr4eBIgsojxH8KCbB/IegLT8/FXTeoK9w6VlHxDDgfamffjak8Ms2qNFjtck
	 GfJ+pQG12zh9P6I0aSbG33T6NXTg/2LBddsyatFSB2yUCv+DgaHSolK1wVGuAEUmpA
	 Fw8d1v68XuyTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9669D88FB1;
	Mon, 26 Feb 2024 19:20:29 +0000 (UTC)
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
 <170897522982.19010.6504853710807455789.git-patchwork-summary@kernel.org>
Date: Mon, 26 Feb 2024 19:20:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: add support for pre-cooking messages
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=827633
  Lore link: https://lore.kernel.org/r/20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com
    Patches: [v2,1/5] spi: add spi_optimize_message() APIs
             [v2,2/5] spi: move splitting transfers to spi_optimize_message()
             [v2,3/5] spi: stm32: move splitting transfers to optimize_message
             [v2,4/5] spi: axi-spi-engine: move message compile to optimize_message


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



