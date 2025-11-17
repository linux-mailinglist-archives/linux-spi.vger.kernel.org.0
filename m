Return-Path: <linux-spi+bounces-11261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB5C65490
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 17:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7397C2916E
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C55303C8A;
	Mon, 17 Nov 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB09P+gw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1506303A3B
	for <linux-spi@vger.kernel.org>; Mon, 17 Nov 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398667; cv=none; b=odYpxydB2sr+qV9WWNLXtTx6thFOs+ijrjPALWLXwTDD+GHHSrgZZYpr7OInAvPXYrk9yaX9NeKZ7XuQWxuToIIO9GYrVuf6aFduj3qCzwQ04llTuPKKdGJPm8fxzEn4nUyOT6y/GnsEuKxXAm8O5gUj0/ijs/4VF5ldtCe6fng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398667; c=relaxed/simple;
	bh=sx1nk2aec1mms/XvNR3mk8Lwh4lE/TtCAtDEiKEiAc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kSUg3230/Ig1kPCdlkP57LTiMxIktbS6Gn5DlAN9fASo5ln6Ijz49unoc82oG9QQJYYTnbDhOtoX+/9nUCfih1OEd48B7FYDKP7RML2t8DL3R9qNpCA/mWcXlyuZ2ZD2pFsGM+FjCHRtpcNr4yhMrCQKrm/3P95nUGiLE8iMNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB09P+gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D87C19425;
	Mon, 17 Nov 2025 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398667;
	bh=sx1nk2aec1mms/XvNR3mk8Lwh4lE/TtCAtDEiKEiAc4=;
	h=Subject:From:Date:To:From;
	b=RB09P+gwJGhjnbjmuvkAdU/5XBqsA0wbAfsB8Y4FKco3NjRgGEiZ0ly1ECguKk4zf
	 7PAXG90VzqiJ6MvHuPesPgjzDqe4dty9GgPzzB3WR7utzjqC+sww484KjSKpeAAzc1
	 2PlYgItjL8dpqwFHM9gMYFJuNHkvjrPSnqMjhkQswQtBcGTlC/kgJCaHeDM/4+9A+p
	 5yZ1ekgyKhMLhPKXtBzYzpzTztW53qdbtD++kp4I7R72kBeq6RM6GBXCujTsKTlH6A
	 SKhqiwRw82jZdVIY5yEYy7+u76MqRkjdGu3ReVn6FACArD0Xy8s8gu/j3K0E64GB8B
	 6M7sIVl4VfT0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711C13809A02;
	Mon, 17 Nov 2025 16:57:15 +0000 (UTC)
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
 <176339863395.3397610.8391733044184576744.git-patchwork-housekeeping@kernel.org>
Date: Mon, 17 Nov 2025 16:57:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: davinci: remove platform data header (2025-11-17T16:12:47)
  Superseding: [v1] spi: davinci: remove platform data header (2025-11-14T18:44:54):
    spi: davinci: remove platform data header


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


