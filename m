Return-Path: <linux-spi+bounces-7220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256FA688EA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 10:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5926D188A1E3
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA343207A03;
	Wed, 19 Mar 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAV7X8o8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7ED202C5C
	for <linux-spi@vger.kernel.org>; Wed, 19 Mar 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378159; cv=none; b=Y1LXu4Y03KI2rDcBY8DOgL+pwnyU1sxf+DQq6wr4M4T/Yb2zpNbBTX6N6V1uJtzwFzL45RxsgI5L8+cPqEv9OBZN5wuejVjwG1iqXThor4rO1JylEJx464w5u1B3+I78DkxnqrCMHcOmFn6KKiotbMf8QP3/0aoh9kBS4h6L4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378159; c=relaxed/simple;
	bh=vaW69X7XeGXg4y+/QomSq0bZHFYU1KUVCUfa2KXEA78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IzBq8zJRdT+EeaPdCfjj8c9OFfsRHwyglXUVaWrt01Rc+P1ij4jgeYlSs10dKV3mYm9/vp9vXOhN3+nGI6i21PUnoyeZGnfSa6tsYcp29C2Dt1p+/pLQoEiOhhyjf3/ARfFzhI3a1zxiTd+3/gSKbN3CYm1O+IoVsvAlCURBM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAV7X8o8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C5C4CEF1;
	Wed, 19 Mar 2025 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742378159;
	bh=vaW69X7XeGXg4y+/QomSq0bZHFYU1KUVCUfa2KXEA78=;
	h=Subject:From:Date:To:From;
	b=aAV7X8o8TPnacExSa5Q33FT8UHqMmSGL3UmGKOvzrXS5JCl9KNKNesE/tGAPZBODE
	 /myjpPDI6f8WDdmQFPDQ1ejVtKs2bYEyHp8noXU1kfimhsN0aiXALrj5glRDasLxBU
	 QJ59GBxK5h1WNOd/AIhUrIkeg93mkXAmlmtQxzlzENzqJVuEQ3WbCWD4ZKHALUENgX
	 51jubvOLG4l4Kpzcisfpk//Xp5LOZf/W8igHGNEp6Me7j37Xa8pejytr34Apf5LQQX
	 k54HymwgKpEdYIYBPdTjZUTVgyKkSVw/Hhrv6cwRcNdQiGbbgHkFTHyjs+3VMdBXyA
	 mFx/5JiRhzX2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3B7380DBF7;
	Wed, 19 Mar 2025 09:56:35 +0000 (UTC)
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
 <174237819435.649601.9430412327615963648.git-patchwork-housekeeping@kernel.org>
Date: Wed, 19 Mar 2025 09:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dt-bindings: cdns,qspi-nor: Improve description (2025-03-19T09:46:48)
  Superseding: [v1] spi: dt-bindings: cdns,qspi-nor: Improve description (2025-03-05T20:01:30):
    [1/3] spi: dt-bindings: cdns,qspi-nor: Be more descriptive regarding what this controller is
    [2/3] spi: dt-bindings: cdns,qspi-nor: Deprecate the Cadence compatible alone
    [3/3] spi: dt-bindings: cdns,qspi-nor: Make the example real


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


