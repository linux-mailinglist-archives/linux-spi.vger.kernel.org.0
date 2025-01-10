Return-Path: <linux-spi+bounces-6321-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ABEA098FF
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BE03AACD9
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1C22066CC;
	Fri, 10 Jan 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyoRtszF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB518DF8D
	for <linux-spi@vger.kernel.org>; Fri, 10 Jan 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532014; cv=none; b=GFqZFF49gPnAyNnhreH4f0y/8EFMniwwq/6yfapTwyVUXEowE/GJVJuYBTK1frICHDb+hP0Cn26XvWB+0IV00QrtVqMNhpg8d/PeV4SqQcVTQ7+Q5kVAS9Hf+yE4AebRR0hQBbZ+pEw1/qJAWoScKgUnvQyUsYJ/qiqJNkEHZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532014; c=relaxed/simple;
	bh=Ot/C/aFRlJGCibnCyOz5bBoZijl1KWgadR9T4e/cXyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oRkdP7yusmRFU6yZhxBVmiVkfhqgvmB1HxfzQvxR7vnwxiQKrTybuLQmlLpELC4Wtv6vaCf4jIqI0QX5S36S1AYEl94pCWGOZGb46C4mIGsvFnrdtKf0bcL/7C4/X/ifx/9HXCv8u5Z9Fv7a+9kcRcmhJF7XHW3qhITQCkdN26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyoRtszF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E60C4CED6;
	Fri, 10 Jan 2025 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736532013;
	bh=Ot/C/aFRlJGCibnCyOz5bBoZijl1KWgadR9T4e/cXyc=;
	h=Subject:From:Date:To:From;
	b=TyoRtszFgmwbMLc+8QSZgFVYQvR7sZKELUTlFPwnGY7FVsp0iq919wcJQAzkHHRhl
	 tmIuPiucfzk3KsWQgwh//WWXkxWc93M6hqGisQi432mK/fr8O+4uCy7YFoHghlilYW
	 MKoEDkCB6vpoR6UbMmdKkkBBFG/gx4FDZrEIEJiaL8gkvvoZ8vYhGv6lizsqOpMX0I
	 jraMqec51+tUfhGLL467SWuQG66zxe5HPKns5AOhB1OeTu5vRIlUxL3sId8p0dHmqq
	 RLrvLgIO5B7Z5Ul26vupwIdqFu5X6xNVXLBKDgKhgstn+nIqUhImWFUdOmaVdGyCMh
	 tJt4AZsVAlxFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2289380AA54;
	Fri, 10 Jan 2025 18:00:36 +0000 (UTC)
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
 <173653203524.2153224.1935673741369520765.git-patchwork-summary@kernel.org>
Date: Fri, 10 Jan 2025 18:00:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi-nand/spi-mem DTR support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=924284
  Lore link: https://lore.kernel.org/r/20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com
    Patches: [v3,01/27] spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
             [v3,20/27] spi: spi-mem: Estimate the time taken by operations


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



