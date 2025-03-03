Return-Path: <linux-spi+bounces-6983-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6721A4BF84
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 12:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D41165D6C
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 11:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C069220D515;
	Mon,  3 Mar 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roH4Ck0f"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB1202C55
	for <linux-spi@vger.kernel.org>; Mon,  3 Mar 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002962; cv=none; b=sYAyXucjTwdXM5k5QT0UoXT5uLhoIZjzysbnyiqcjvqo+Xhg3n9C5Ev5F7MQR26vT+jFHJGGDqfutOSY1xgNxWRgRHZLsmteSilBLG1f9satlFdWDAswHp4jWmZ1dS0aslgrkTbjfSQG3Z5SS4r1ybGA8G0TKZsa8jA0iRna6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002962; c=relaxed/simple;
	bh=uca/+ljGielTSN3TiA9fb91AbH/hCjWrK+iVoqFkcqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mez0cI25Oan/Sg/2C9QTmg+VQS9f6Q3xalHgsYSeHXbQbGEuYRjxRpny4sYeyTY7gQ2AP5baC21zapNp7Yie3dscX2W9FDAyyYReT+K0KPEla8o0zivvANlo9yHi1Oog8c3vMrWAqf/pUE4n8igzuzfFX9LmU5yzzH+A3PJKs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roH4Ck0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C13C4CEE6;
	Mon,  3 Mar 2025 11:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741002962;
	bh=uca/+ljGielTSN3TiA9fb91AbH/hCjWrK+iVoqFkcqA=;
	h=Subject:From:Date:To:From;
	b=roH4Ck0fOYQbmUFQ8z7kUyAqfaw2w0rzzutJaTeLcI3IdL4CuYYKeziE+zg2Ff8lJ
	 njdO/YxDEMKtlWbJB/DqdP9qTFQ8UXlFZGuNU8ZSryjNOdB31eqf9L7YMHhYsn+xXk
	 TF31d/D9jDMKvI5PRqPmz8a3cnW9b2vW0jefTVXExiMqPFldmjXD2DAWZ9RajGbFjf
	 bvAjrq5y/0cTxNb/0IQqIru3b2W7il3WwY8hcYX84x/39/g5xRrW808PITP9fkjvAz
	 JOSNq0yPAn4A4DOZl97LXn/dusMOtOK3DHLiiwiKdbdyI3r+G2NMr7lDHZkMr0Vlsw
	 ygr9ehDy2wFPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42CE83809A8F;
	Mon,  3 Mar 2025 11:56:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174100299506.3550948.12336843357804126762.git-patchwork-housekeeping@kernel.org>
Date: Mon, 03 Mar 2025 11:56:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-mtk-nor: Modify the clock architecture of nor controller (2025-03-03T11:45:07)
  Superseding: [v1] spi: spi-mtk-nor: Modify the clock architecture of nor controller (2024-12-12T09:20:12):
    [v1] spi: spi-mtk-nor: Modify the clock architecture of nor controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


