Return-Path: <linux-spi+bounces-7113-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAEEA5F381
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 12:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B87167767
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C631266582;
	Thu, 13 Mar 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X69bgB1T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676011FAC4F
	for <linux-spi@vger.kernel.org>; Thu, 13 Mar 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866964; cv=none; b=FS3VwEbn+vQ67qvIufUQHodC9zkGKN0YvH3aCCEF+0NyHPtnA5gvNgV/m7YhEgW5sXNZ70b00CFsX5Ex/By8JoNWMXnRN+T+8sNTuzTd/RAFqn8i0x12QR0OTg9rNp/lOxsQ09GsjGxs2VcyIn2Zw2Di8fOdFETKO2lTsp7E+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866964; c=relaxed/simple;
	bh=w3s1guKX5ZbyJup4MrJEd1HGmwEPNn+NqKWsb6Cu02I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WU7+87Ar5EduuRvLURV91w4wyYcQlqVq8FVwn+fmLL8nbGs6vZpzdfvN0DFIpJChOhWC6p6JskyUohZA7wGyH1RNCHohJW0IbaJ7+Pg5/BAd4TPj5jXl/c1leRyujOhHK6hY89ZhE3A4VAH6XcVi43attVv+A9oIjMzZZIhP8dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X69bgB1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2264C4CEDD;
	Thu, 13 Mar 2025 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741866963;
	bh=w3s1guKX5ZbyJup4MrJEd1HGmwEPNn+NqKWsb6Cu02I=;
	h=Subject:From:Date:To:From;
	b=X69bgB1T8efXEH6/KVxb3U9nvvJ8Zpn6Mhc4AaGf5JZjNfz+3l/MaygXEGsXnGmMW
	 OeBliDnaN8nkbERYkYwuUZKUXzctsFsPxbDxhimHF5tlYCGhITqC2Bl6oAAZfh7iDm
	 DJ6GfjDb7vL9YXe4mi3I8ICk/ujunlbaYm0vupR+ACnxsK0TuhKccItdWnXcs/Gxq6
	 nfUCbhDlfcB32SKQWMPDJ+KLkcDVZCutA9ELkjGE0FhS1M7YTp/qv8gEr0DgrwTQ50
	 ttQtRDBrDbvJ8gtlBVX//8+w5uxPTGKheNw7jxGCpU061HPkQ+lY1x2463voX/WORx
	 3zn4G8Ai2vj0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE533806651;
	Thu, 13 Mar 2025 11:56:39 +0000 (UTC)
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
 <174186699841.1481839.3314756316348472872.git-patchwork-housekeeping@kernel.org>
Date: Thu, 13 Mar 2025 11:56:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: sg2044-nor: A couple of cleanups (2025-03-13T11:12:58)
  Superseding: [v1] spi: sg2044-nor: A couple of cleanups (2025-03-12T17:19:16):
    [v1,1/2] spi: sg2044-nor: Fully convert to device managed resources
    [v1,2/2] spi: sg2044-nor: Convert to dev_err_probe()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


