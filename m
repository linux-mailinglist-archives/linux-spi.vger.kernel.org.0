Return-Path: <linux-spi+bounces-12238-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42310D0A1DD
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 14:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8E2A300A92D
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C493596FC;
	Fri,  9 Jan 2026 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuQnlV5b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD335B12B
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963598; cv=none; b=hRdql7SfVe61PepOndzs4VJbjTQGrXDfLrKqOtKSKkj/8OSn1dbsfOslH9uYVIjDu/na6qiCK9+5M+X01m+8JURSQ/qA36nYqGri679ihZp92/IMD0ZuIbb/imALOnDWDw6sKzHta4MccokQ9RC9A8YfE7WGWVKZUTi2LjLfFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963598; c=relaxed/simple;
	bh=9FrsQlou9Iky7iVPOJLp5FgzZZwiA306Iw5u6PQI0sE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jXecvLpSFUvrRfAq1GC/BGRer5aTshIbyvSVzeJrV6Nno6qF92P+LofDAw8h19gcecj1CIfMv7vW2gmEV/kC33sTGwP9fTIlpSe2vDFI/uMNzYPUSiyEUT0h+8Dh24WTh8Ke6Kh0Z2rnBmsCBilMSykbW5yGKw8Yi7Ah6FcD6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuQnlV5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F77C4CEF1;
	Fri,  9 Jan 2026 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767963598;
	bh=9FrsQlou9Iky7iVPOJLp5FgzZZwiA306Iw5u6PQI0sE=;
	h=Subject:From:Date:To:From;
	b=IuQnlV5bACtnqETRlcjMnTp1rnIBYy+j3p970nug36GzByFAtA4dDJD5B2DCXD0Ig
	 NMlze5sk8V+acN1Y1dO4lb/CayF8pIKNV4kLF5osd8i8IugTqX5nhokG5TYVx6KM8d
	 Q6BlpoeI+9qWCPqYJ3FIizimn3CV/qI457DxAcY8dtdDUQxq1tYT02MDnN7w/+a5b8
	 iemS4fjHcHM/raoKttPXIEjxoj+ylspk2w/ZJQ/MOSMW8MEU9RbwLk0zqX/67GSALI
	 OyDnKdXOeOHy8z7KEyIJXE44kUj80htvhZvsluCOmX1cSnh5q93vdWlzSiBunGW3Cw
	 qY8I2QYxjmy9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59743930CB0;
	Fri,  9 Jan 2026 12:56:35 +0000 (UTC)
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
 <176796339426.245878.6805940078537999002.git-patchwork-housekeeping@kernel.org>
Date: Fri, 09 Jan 2026 12:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-sprd-adi: Fix double free in probe error path (2026-01-09T12:49:53)
  Superseding: [v1] spi: spi-sprd-adi: Fix double free in probe error path (2026-01-08T16:12:59):
    spi: spi-sprd-adi: Fix double free in probe error path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


