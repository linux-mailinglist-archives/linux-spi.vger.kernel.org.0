Return-Path: <linux-spi+bounces-11778-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3887DCA5E42
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 03:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D73C306386A
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 02:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAE0275114;
	Fri,  5 Dec 2025 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xwqOT9WL"
X-Original-To: linux-spi@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF622DF68;
	Fri,  5 Dec 2025 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764900902; cv=none; b=fsvxT0zTohUBdMnx1lbfvkT/aStXNl8rz2sDCkxgFITV46/Zqv1DNnnAFvS7GWQzelLzfarJH0vU3fQeahbdNGavcJNqETXmLTqgtIs874ciRMYflwVrJ1JMEWvaxp8ySJZRr/PWAvNZig//NMIiF1TEuRuMw3r4+iOuSa+poEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764900902; c=relaxed/simple;
	bh=1jBgGZrbnvz6TvpcS9v6xCJsQWOXvPzs5uoFpTNxnpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7qrNC6Owd5wx8ERoZCuS6sFAwuqkAMBJ8yhlqPW23guHcAv2CmVVe5rkB7a4/jXmOXfeyF11FWve8fFyQG4gNT+gIyQ73Pr7/sECjTA2Bco/dJMGLx8fQHInSPoHRiwj37agT4EP/ciI7kN87FQPxOMylHI/wHVpIW2EVjWdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xwqOT9WL; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764900891; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8x8yDGiPiaVqiO9oDNm2Rr9h22sKxw+4xDi2ivLKKA8=;
	b=xwqOT9WLhxwS+4kAvf9YR4JX3EFJBUULGCx35xHEWK3tTd9/Z0SdsYB6oXAMoagbBlWTqK5ox99XyieKIF2MR97DyXK8BiLJVIqFxFZzEmrEMH2AKUOQOWqtTckzklbXBZVXO8l3WVOCOmVst++r8ieHT2g5b/HL+5XVuj02ETs=
Received: from 30.178.83.110(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Wu61cCo_1764900890 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Dec 2025 10:14:50 +0800
Message-ID: <66457798-e67c-41a1-b1bb-fc8c253c8b30@linux.alibaba.com>
Date: Fri, 5 Dec 2025 10:14:49 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] spi: tegra210-quad: downgrade the log when fall back to
 PIO
To: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <20251127130207.43754-1-kanie@linux.alibaba.com>
 <16bc32ff-2c10-448b-ab82-a21eaa91f4ce@linux.alibaba.com>
 <cb9c67fa-c95e-44a3-b906-8f64bc4a9e29@sirena.org.uk>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <cb9c67fa-c95e-44a3-b906-8f64bc4a9e29@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/4 20:33, Mark Brown 写道:
> On Thu, Dec 04, 2025 at 09:46:26AM +0800, Guixin Liu wrote:
>> Friendly ping...
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
>
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
My bad, sorry for the trouble, and thanks for the advise.

Best Regards,
Guixin Liu


