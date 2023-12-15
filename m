Return-Path: <linux-spi+bounces-303-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E65814DBA
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 18:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680B4B21C9A
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8453EA70;
	Fri, 15 Dec 2023 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8Dim8pT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C093EA60
	for <linux-spi@vger.kernel.org>; Fri, 15 Dec 2023 17:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DCD6C433C8;
	Fri, 15 Dec 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702659626;
	bh=OEV2u2X1uRAtR6u0iwAddzaBD0uDgoejnsd9A1UrIO0=;
	h=Subject:From:Date:To:From;
	b=g8Dim8pTUk0gGOLFm00ErGd62MyuQZaVV+hUSuVyELrRSe7IdcLpSq62FzXXJPKQ8
	 XS9yznjGkbmWwpeqkvf/ohNN+gBcErbVTOfejWo+/aHCVYAotB485yhSmq4/XunGba
	 N5eS2mRu7RKxFGFupFsFAC5lukXP6PupePNvh5WtHPgXmofj2j3+QGd8Qynr7Btrc2
	 hsdgqFc1aiyC7C3ipfZjUyuCS9ixy8SQ8+C0LayUo2WS5VwTlFvjJYps/90UPkm/sz
	 7wH7F6/SoCxO4UKfIbxZnd/Y4eK9zkSh+cZz3qcnsTFhHZzAhhynPLq+oOeQkgw11H
	 sybIXh7FO+Wlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 678B9C4314C;
	Fri, 15 Dec 2023 17:00:26 +0000 (UTC)
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
 <170265962631.31240.546439706114934551.git-patchwork-summary@kernel.org>
Date: Fri, 15 Dec 2023 17:00:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: pl022: delete description of cur_msg
  Submitter: Nam Cao <namcao@linutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=810442
  Lore link: https://lore.kernel.org/r/f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de
    Patches: [1/2] spi: pl022: delete description of cur_msg
             [2/2] spi: pl022: update description of internal_cs_control()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



