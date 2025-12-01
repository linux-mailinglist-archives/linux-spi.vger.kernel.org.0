Return-Path: <linux-spi+bounces-11677-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A81C97285
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 13:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C363A15C0
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA92F4A10;
	Mon,  1 Dec 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc1zekGh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FE2F1FF5
	for <linux-spi@vger.kernel.org>; Mon,  1 Dec 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764590399; cv=none; b=SmjqD1APj5SXVzoTWb4LPTqXzNDZ7VrVLT02pu9HkEf8SNQU78mMRXwSFunS8QQXDDAQWu9HCvQzeNzaCiHlpYe9wkDFl8NgdMb72hARD9hsoXTOOA09I2sNWQvow/iZcuqZpkWR80gSc6OcudgV6PTJ3h2KAAu4BHtyelM3AFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764590399; c=relaxed/simple;
	bh=RMLlyJ1NtoAX6/h8OrYaGmV+QgA/p2cqOF1HyoZj3yk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=REvUuGNJa5YUHxMXUQiLD+MxARuGItLCtfsae39fweEpj/g6yZdxKNmlOcpypxGPF18NX0IkP5H/dL+u3vBCyyfnsb32MO8mbX34pC4HQlyxoAsVO9qUGPVioThtcL5CFbbTVlIi2eQFUJrRu+CN+V6JZh9G1aIogBoTwd9MWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc1zekGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCD4C4CEF1;
	Mon,  1 Dec 2025 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764590398;
	bh=RMLlyJ1NtoAX6/h8OrYaGmV+QgA/p2cqOF1HyoZj3yk=;
	h=Subject:From:Date:To:From;
	b=Vc1zekGh4NaC18Q+yfFwpJIDZ9E2m4ZDB8Hu16AChLPxKz5QMSLF76RJsVxxZrcEh
	 Ms8j5kVh7O9DZ33OmRA5c6bxJmhzgtPNEoo/naGlSxNfToq568V1oRvyW0Gxhlrmh/
	 ppxKSCzxjnZDD+QlFfVWeYDl55zrrHonHL0UhR46JMraPaMXwQVNLcveiHWfF25wZC
	 rTJamcyYXcNtk5OgxBVd/Cj5NNtjWr4yhbmLZThkXfNJyG3HF1M+Z3R2dvp4+3eS6S
	 L21xvkZRDmD29AJgcKWwTLjZhiflH0P7aycZ3qIV8DgHXg3oxjpFUhuJJKYXqE3meo
	 t5qJ2S11DztoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8A0380CED1;
	Mon,  1 Dec 2025 11:57:00 +0000 (UTC)
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
 <176459021875.2339640.18341863066123535795.git-patchwork-housekeeping@kernel.org>
Date: Mon, 01 Dec 2025 11:56:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] LED: Add basic LP5860 LED matrix driver (2025-12-01T11:19:46)
  Superseding: [v5] LED: Add basic LP5860 LED matrix driver (2025-11-10T06:35:32):
    [v5,1/2] dt-bindings: leds: add lp5860 LED controller
    [v5,2/2] leds: add support for TI LP5860 LED driver chip


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


