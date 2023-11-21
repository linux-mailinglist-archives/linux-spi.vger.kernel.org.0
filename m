Return-Path: <linux-spi+bounces-1-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FAA7F22E8
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 02:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C531C2114F
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 01:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6513128F3;
	Tue, 21 Nov 2023 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n7fgiWhe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24433FF
	for <linux-spi@vger.kernel.org>; Tue, 21 Nov 2023 01:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C928C433C9;
	Tue, 21 Nov 2023 01:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700529052;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=n7fgiWhegopDfrHX3gDPX0yuGHMo6iQSeRMSNZoZrcKlqzs1dGcGuHGdjH66cLIFD
	 xs02S+t7GHKRd/yBvF1tiyZ6DfP0GNrW/e6gS5aPmvTjm2dRgt5DLcZQAUnHATIKc5
	 C2z9bOWRSRr5v7MVv54qg6lG+3OGFUp4iCH4Sr1g=
Date: Mon, 20 Nov 2023 20:10:51 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-spi@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-pastoral-festive-dinosaur-afee15@nitro>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

