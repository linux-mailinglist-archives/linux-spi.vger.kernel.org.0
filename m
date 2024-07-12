Return-Path: <linux-spi+bounces-3840-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B65292FB95
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jul 2024 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B08CB21A7F
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jul 2024 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BE16F0E3;
	Fri, 12 Jul 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST7f4Wlh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DF158DC1
	for <linux-spi@vger.kernel.org>; Fri, 12 Jul 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791631; cv=none; b=r92Kspo3BJe0slr23E1aWmX9Q+1Cij8LSLR2YSZM86jI21+el1LOa5SJlT7uBGa7K74vpTzMJfhxtC75jKoimKl3OBCk4k6Gr+DLTpw06DoS5vV8xVdUJOKcB1fH4cIEnnC05Y2D8ThZFYuvtEidx+y3T01R+hA7aGiN6Sjq6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791631; c=relaxed/simple;
	bh=PUd1jE9aebAoPzBAiFg9iyPOBLKdzQQ8SH/OWT8Cn3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=t6NvS5voN/gDHNRAop7vNF9KaG0C6HD0JAyxNHZZxxBy6q+x1kau8RLxGsg8V0O56kX1cQbhLpNrblHxkXiSEL35Qfjk2mEBRzsPu4tJW3/v+bMLgf1IhD84te6l4BoANl1/qokpz8kJ2cgcS8Gizqjx/r/zP1LrWSsUNe9xisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST7f4Wlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D809C32782;
	Fri, 12 Jul 2024 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720791630;
	bh=PUd1jE9aebAoPzBAiFg9iyPOBLKdzQQ8SH/OWT8Cn3A=;
	h=Subject:From:Date:To:From;
	b=ST7f4WlhYyKtOhIhtl+hstjlU0ygttdv6Y1IGuVaxgL7Fl1yfciz0TLUPudr78ldJ
	 ELIJYr8z6lSMIkZcxmDhuy0fZt+mFDBOeFwdhipvB9zLWEWWYulEd/AT3On+WXUxU0
	 KmqR4h950TGc09SfACQR0uXm+gnyhTNBOq1P6HVa4JEC7juFLUqvskCjhxo9pBNLAJ
	 YPHL7161NBjWTTfrP7UZNgtejLoJIMPenkbNl+JfpfIomWLG2ZcZAyT4QK/reH4PHl
	 Ul1wpqby0dZ7lm71MplXLP2GFu2vs+hMro2eKfx1RzKjF4A1wdNJG1SVv0kMn/6q3b
	 YAxWQgyZB7E4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85897C43153;
	Fri, 12 Jul 2024 13:40:30 +0000 (UTC)
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
 <172079163049.18413.9267191364087973962.git-patchwork-summary@kernel.org>
Date: Fri, 12 Jul 2024 13:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: dt-bindings: spi: at91: Add sama7d65 compatible string
  Submitter: Nicolas Ferre <nicolas.ferre@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=870561
  Lore link: https://lore.kernel.org/r/20240711165402.373634-1-nicolas.ferre@microchip.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



