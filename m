Return-Path: <linux-spi+bounces-7014-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55820A4D73B
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 10:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6065218986FA
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D01FC7C5;
	Tue,  4 Mar 2025 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR8UW84n"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4C1FBCBF
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078560; cv=none; b=KlLgAOJTE7rhaaJxENR4CTMQr5eA1hsyRy0gFuy5y+zYXkNWxE/NjPh6irF0chMc4puz3xMOA8wnSMVTsdfC+dx0iJWlJoNTvIpTS5JP3NW5QUHm5uj2Mz5JHWdqynUajID1kfsr8JtNfRbhOJG6fsrdFyLaV7NembEJp78vMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078560; c=relaxed/simple;
	bh=J85cqAGYpGay7OJcHf/jPjvBapGtPejBnieAZF3dq1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SFoHtJj1d17pAFtBFM+s3x8t1arbx/rezWleFZdvQ0BjggrS2+D3IEdspJMW/MSQyZ02ZPywnYDS0G+iJ6CPHMdNYfYJ9l35Hsn9nV+ItW3k5uTNPUsO3Wg+1HHp26W3GL6PSi6BUNMxdlhWUEvlQziPd+7xi01iMc3MC+RCjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR8UW84n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACB2C4CEE5;
	Tue,  4 Mar 2025 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741078559;
	bh=J85cqAGYpGay7OJcHf/jPjvBapGtPejBnieAZF3dq1A=;
	h=Subject:From:Date:To:From;
	b=FR8UW84nCNgxOTaAAwlRxRPjeB3jzMjWzXyMMz/sp9b9vo/0fNceRoc1b5EqyBBG8
	 0QZL8Q+KulQNusvwRCER9UOUSvn22zviWe7LbphhOr3i8sSoCdZNNSO3g0fPhzUKQj
	 vwsQjJHG5/vOCxV8UtdYcDUTXgMXNJ+BO30GHZ0+ZeSU0h91M+y2eHo3ylDZDdZab1
	 Hk0ubuiQw6s9AWOHIcknC+b5mP00kDhV8lrtP7VK3gm1lQJOXDOmEJ2wUmuF8b0qzl
	 4D6Sceqy61SzY09nY8H3eZ7Yc4bt8fKA0Tub6Dbdsls1VIeLxiQAMZUgKWS7iqhcUz
	 5V3jI+8B/WxmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE03C380AA7F;
	Tue,  4 Mar 2025 08:56:33 +0000 (UTC)
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
 <174107859221.3922645.11946852110537312012.git-patchwork-housekeeping@kernel.org>
Date: Tue, 04 Mar 2025 08:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: sophgo: add Sophgo SPI NOR controller driver (2025-03-04T08:35:41)
  Superseding: [v1] spi: sophgo: add Sophgo SPI NOR controller driver (2025-02-24T10:11:59):
    [1/3] dt-bindings: spi: add Sophgo SPI NOR controller driver
    [2/3] spi: sophgo: add Sophgo SPI NOR controller driver
    [3/3] riscv: dts: sophgo: add Sophgo SPI NOR controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


