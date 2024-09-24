Return-Path: <linux-spi+bounces-4945-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A543C9846E6
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A681F22A53
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446C1E505;
	Tue, 24 Sep 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="uEFZYusm"
X-Original-To: linux-spi@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC381145B00;
	Tue, 24 Sep 2024 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185223; cv=none; b=jSKVIUR3/1tMFo1HN23LgKaYNbxbHW1TrcPZN3Q1w+dUsKL5549wozNsFf0L7EEdoZ+Hf1iaZPp7eZFgPHnXkj453lrefctUdjlxFAGDkakfey3jqZlB8QKLFBDfEXbTwoF/cltpkAKabMPx+tqI5LbclO1DrY+3dGASH5Pa1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185223; c=relaxed/simple;
	bh=wWb7oFik+JeN85mGcqrUjXCKV/kKmKZ5q4ay0lRMM3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOwxkjK0k32odn8bOooU7ChX0aHBmWSwSxVSXI+cQfzBDVhCHrQlgfYvXy51c/afNcjJUEXnptLd3RWcItxyY4Cd0StPcygzQH7bUrt+vfwAGdwTTOMQqRFKJGmofOfJ3TGCArZykIXfi8ZwF9kqERLek6EF0o1IStquFXfKTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=uEFZYusm; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wWb7oFik+JeN85mGcqrUjXCKV/kKmKZ5q4ay0lRMM3o=; b=uEFZYusmuBIgnAs/GJU39HpWVN
	g/REle13YUaGUGN9MJ57cbnY6DdLCdZoeZW/GtHErQDV0RkRxFsQEihTm0CSQdHX4YIOhojLK8C2m
	9/kABqBB5YdG+UvUX7dqCfmvbN3kMwhhvWTlJsdoF8DaeU8xm2eKQuKe5TSZ53Dja48Qmz2JJ/vbW
	BFoeaYQB41X7HccVz9joxMQfraY9uL8rA9PZOcmTkbFP9oGUZf1ogF1Leq52691VQveK7+nSlew4I
	CqTVVEDctOtZaB2ilvXfUrNh/bdqEtdDSy0yqxrWD2JhSoBawGeX7irzJ+fq7SqPGvd6NeKlWS5fV
	Ld/VwK0A==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1st5ly-002wbg-QA; Tue, 24 Sep 2024 14:40:11 +0100
Received: from ben by rainbowdash with local (Exim 4.98)
	(envelope-from <ben@rainbowdash>)
	id 1st5ly-00000000UFO-3YSw;
	Tue, 24 Sep 2024 14:40:10 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-spi@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: two (possibly bug) updates for spi-s3c644 
Date: Tue, 24 Sep 2024 14:40:07 +0100
Message-Id: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

When doing some investigation into customer issues, I ran across a
possble bug in the fifo flush code in spi-s3c64xx.c



