Return-Path: <linux-spi+bounces-697-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC9483AB3A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 14:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9FEB21BE5
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58F877F09;
	Wed, 24 Jan 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlCBEWC4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82325A48
	for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104598; cv=none; b=C7zHLmZbilpdHWZZIWE+UxeA4wO3OyuLxb7LxSip6BJ8cL/P0vRiPAluI0TJLO3x7P0IK2Q+IfIKGn58PwO3xoyGfRYxdSkSOpeqX77btfB/LMDAGVMFRIjW7E1hZ0y1h94zGJz2sfwhOVsP5XFe7l7d5f/kDAzRL/ZqKdfRBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104598; c=relaxed/simple;
	bh=n4BXElY8BcTCyZs/Zri8OP0hfiI9QHCOYu3UfRNxoSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=eHZIRds/7fUDwojTMz0aTDWjbpzJ19qdUf1EJs7R+h040FiQX1eALOLiNw2LJa4ZNzLpP+Yy8EKLzcBIg7NnmFu7+LGMNkW3lDpHLXUGzLvuklwAuS0HXmZP3VUuTQ1aW0vAIDtfqo6+0NXUO6wEE0bUwsfTkOf5Zm3H7lSDuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlCBEWC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E139CC433C7;
	Wed, 24 Jan 2024 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706104597;
	bh=n4BXElY8BcTCyZs/Zri8OP0hfiI9QHCOYu3UfRNxoSQ=;
	h=Subject:From:Date:To:From;
	b=PlCBEWC45hhgo9qbJfepex4JGNI5xCwAlwuXdqb73y41lQUdIjoLVYJC4tu9udHCu
	 Cj4RvEFeXA8+zMwz/jmBhpSvQCRP8tH1/3mfO0TK16x2UkjS8n7kjHReSNVd9CXjCx
	 eewEscj+J6MsAOvMnTMMCRSVcEVPUQj5+I9khrFV/C8h3Qr2FutAclDs3oV/P9H7r8
	 j4FKbrjOc66HWzMNxEs5TyhHRakL2+X0JNy1/z9YodKs+QLrOPzoqvu65frqWAaTBP
	 IvUttWurPGFcuDh5uUEnRi6DUsoYWBove+WqKCKCgfVk+YuCBUQu5FExUT4MMWMRvr
	 oM48HANXssEmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1187DFF762;
	Wed, 24 Jan 2024 13:56:37 +0000 (UTC)
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
 <170610459773.27384.12320597984105659098.git-patchwork-housekeeping@kernel.org>
Date: Wed, 24 Jan 2024 13:56:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Raise limit on number of chip selects (2024-01-24T13:24:24)
  Superseding: [v1] spi: Raise limit on number of chip selects (2024-01-22T01:21:46):
    spi: Raise limit on number of chip selects


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


