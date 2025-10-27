Return-Path: <linux-spi+bounces-10846-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E72C0D59C
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 12:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ED818958E5
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B92FF16D;
	Mon, 27 Oct 2025 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7AfiWX9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7E2FD1AD
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566249; cv=none; b=EXTmk3xA1f+LQ0elS5oJH8JZbv3DZp41NrrEt6dnAPl5I4lBNtGUXLkA9g4PvDqUgbz4buVZY9WC5kKALeGrM2q4HORead28V5YhcR15kcPsabRX/klKXITILfd81doljsqyMtiR+dw8H58BpEug3AjTf5YFV2Ce7rkoq6e32LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566249; c=relaxed/simple;
	bh=cnzKbJecJt3MusQlrnROcO2OVm+sgp6cWIUwUfKKZn4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=F5X70hyIPhw852Js5u3HQSspTjI5Gy/7WMhjDBoPJJAslP/dkrGdQVCDHpRVGW5ZxOVwpOidfKolenUOHPByBW/iWVcJJWfue075z4FBsvgTrB+GP8WNrCpIRqMrDs/boYpOBQn6kzkU+o05LHpKda5KDyZ6ECD80g+iteVSL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7AfiWX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AACEC4CEF1;
	Mon, 27 Oct 2025 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761566249;
	bh=cnzKbJecJt3MusQlrnROcO2OVm+sgp6cWIUwUfKKZn4=;
	h=Subject:From:Date:To:From;
	b=G7AfiWX9e4YjAWHLMdkucRtPjYhxROdKi96dFy/nYMblZHQS435L6I1kj42Lmb7gH
	 jMWE+GV1bjSISvBbN+noYXb0wG6XQ/mdfBHa3oNMH2Ma1UPjRkRhp6/c+rk97QJJ1D
	 CJHDYlQgg+5RjkwVPHi94CYscmGTqFOaq8BBEZQe4C6uUl1yVqgBKQVP0LiuuKzapE
	 wlIFeKadArQH+U49LnacLvadXV7asroTWT2Y4S5RIMfMt8GxH4q+52hD70n0w+VvTu
	 Lg+h1yExu/ZNQDuAHRgnlGsbwJkgIkrJiG2HhrjuQJNiDKmbsYgY6zTjytMTNzrrKo
	 MzkRr3vExkkRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE4380CEE6;
	Mon, 27 Oct 2025 11:57:08 +0000 (UTC)
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
 <176156622787.1332486.19439689560250479.git-patchwork-housekeeping@kernel.org>
Date: Mon, 27 Oct 2025 11:57:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: imx: keep dma request disabled before dma transfer setup (2025-10-27T11:04:06)
  Superseding: [v1] spi: imx: keep dma request disabled before dma transfer setup (2025-10-24T05:53:20):
    spi: imx: keep dma request disabled before dma transfer setup


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


