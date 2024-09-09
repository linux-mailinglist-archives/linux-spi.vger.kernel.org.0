Return-Path: <linux-spi+bounces-4749-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17BF971BEA
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 15:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5B11F235B2
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7A1BC9EC;
	Mon,  9 Sep 2024 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJLDuuYV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479581BBBF8
	for <linux-spi@vger.kernel.org>; Mon,  9 Sep 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890221; cv=none; b=ES0UuV63//SdADYJec6gAkuZTYZX3FnFdCuEkz/ykk9jQ90iD7DJYyUtbT3YJOwj3mqBf20lakkjuDmrJSevmmRW4zJB7FtAlaO4GSJ+wIPacbgvv4bWRhqGL8DJs1W5DTGBuPA0cYfz/ENqBtpcicYxZDvGM6duF8h7Ta9imzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890221; c=relaxed/simple;
	bh=4jHx5fb7l6qsQQS4X/QdvQKNPhkWMcRQ3cdd63XkQ6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dIEKx8oH9zuCtWNnSOWkmkSKB6pQT7vEnGHy4P1uwFQb0sfuxjXIdaNwkQyjZBpEoPkzIDPKfe1kTolbqCT1Fa7cLi7M828RwPYa5mMjitGEVvM2JMgzEUZkteR6UFXx7MbsDoXHJgJnlaV/zQSRxRe3K6dIysLbzqaAZOVll+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJLDuuYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FD9C4CEC6;
	Mon,  9 Sep 2024 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725890220;
	bh=4jHx5fb7l6qsQQS4X/QdvQKNPhkWMcRQ3cdd63XkQ6w=;
	h=Subject:From:Date:To:From;
	b=OJLDuuYVyXOxL4oVc0G/FilVlKM0U7OV4BIZbs1yiN1amB7YxLeaJmypPG24SA/li
	 H0rxGnaYdFUF3kzjoQqu2C3IhYRLGsIgosDvVZhM4mjck+Xn/q6Z1cztgfP+FI4m6u
	 1mVi7VnsZXGP7Up31e3JcsJCV9ATHw44xwE0MLLg8mIEDubsStJ17ZfP0D36Hgem30
	 yKSPWjdZHWTmKD2MFFbBGB1CErP3QzVREbgHrZQDPWLQ4dO8+nsmaiFydtKneSZJaQ
	 wCucdrQEUIWWgOFvdFtJZNXOI6QO/hj+h2mElPoTa1HQOf4H5sb5FkVRyomgWktHQa
	 K1WHW6W1phDGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4153806654;
	Mon,  9 Sep 2024 13:57:02 +0000 (UTC)
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
 <172589022148.3781516.8990774683690719603.git-patchwork-housekeeping@kernel.org>
Date: Mon, 09 Sep 2024 13:57:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: geni-qcom: Undo runtime PM changes at driver exit time (2024-09-09T13:28:08)
  Superseding: [v3] spi: geni-qcom: Undo runtime PM changes at driver exit time (2024-09-09T07:31:38):
    [v3,1/3] spi: geni-qcom: Undo runtime PM changes at driver exit time
    [v3,2/3] spi: geni-qcom: Fix incorrect free_irq() sequence
    [v3,3/3] spi: geni-qcom: Use devm functions to simplify code


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


