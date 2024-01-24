Return-Path: <linux-spi+bounces-738-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BEF83B36D
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 21:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C47A1C20C11
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 20:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262C213473B;
	Wed, 24 Jan 2024 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j16IfxCc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEE811E4
	for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129962; cv=none; b=Zhwwr95A82eRMUb6Duib6aZIt1IqMnzNiyfUhr45YnSx9On9SUKeFdj3zI6JuxeBWiOCaKu9Erdd0FKfxnXXhL8X8ZBH9xrnh6ZCzxMmRnZTb0ybSI2QUp6KSmRh0X8qM0MPF97m7Bd48Z31aacQQ8RPGX1hM7VOHvwOFZYcNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129962; c=relaxed/simple;
	bh=aVGREhYovkni3n5pynjybFy24EKGriWiO7qjRULRuSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2qhTDjBWE8bea0rGkWqM0ISHkTYtXxtA+6Qn/dibV8nNLoRq6WW/YGW5iNS525OmFMqcaQ3BlkjTAYS5tHUVBwW9Me7R+OJB2Yt6sAwAgkJ1/epv3IW52vH9PtSwsaTHKsvlP72kvq0218G3lX/yo2jRrMFjKHJgjT06ESPVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j16IfxCc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3107d2bfbaso115151066b.1
        for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706129958; x=1706734758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVGREhYovkni3n5pynjybFy24EKGriWiO7qjRULRuSM=;
        b=j16IfxCcZT02XAhF5ArV2/JWj9EaejCJCqRulRuPB00wuwGsqpk5uodq0a69iI3ySN
         nwHbGjJ3U86MwHd3dxPeBZTqOed9i1HuKbZ1DAIRnxv4SHwpIdb3VT9sf4FZYeF8qB2Y
         opOlH8v0hDy6+/3cyb9UFcAdCP20Dk4RccD7rTBIE367Zh+IM4oLECo/PpB7Ga9fgqNK
         cNV2lJMhuKOeSqsRmZrpQ6tin1xziU+ZtQXZyt8iZJE0ZIPR3VsIw8OmiuCUF+ikH5Q4
         BD5LyzmK3Di60GP4s39/k7KcWg6IpWan62s2BnrBVCbckQdwzk4QNszFHTggw3AXZ4/h
         EO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129958; x=1706734758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVGREhYovkni3n5pynjybFy24EKGriWiO7qjRULRuSM=;
        b=h9oDu/GxeqQ9tj4GnYFQ2WyqyeTfPymqZC+kTRutj4iwbZVmMx5c0Wxj50bm+cru0X
         nOIXDd3mjJh3SPh9zssj2WJutPTdAeMLF1fY2ozdUiqBIUa176MU610NHC/e8pZfBvB/
         /UtMEmC5w2whWfG6PHbCx04y9O15KM4cpNKdWyK3zkf0TYgqGPmJwxhJQz9Zb+aALguO
         NGvD6QzgZZ5Oa8dU9R5N0ULMK60ryTDXvrN/xjz919rXnLCFRJJps0TomuZj1D1BKo3A
         KakJV7vKVxEfZnn8DMEQvuiblJmDkk3dpwma7hUNxV6JYiqLW9fb7dtrP0ImyV0WncH+
         nBlA==
X-Gm-Message-State: AOJu0YxzRqKuj2Vhsh6dmaC6O72MgDrVvrr/WnwT+IzJxsyStNAk2YY0
	3RZKc2ntc/QgV5xG7SAlCg6xNy3oMKp0wp4CdnsJiIeAqo4u/PUDNYh86EgIRKyyHIFcJLJLRTi
	DWB/EB9y/ggwVnpDZG4w2GvBbGBw=
X-Google-Smtp-Source: AGHT+IHRnB9pEK7VxLzLIp03Ea7ICel1Isk/V9QLWMetTNgrpsHhdyBSCJ+PN2V9HmhKHbMUejNZ/7t5R6Ygj/w2WRw=
X-Received: by 2002:a17:907:c717:b0:a31:4e96:f40a with SMTP id
 ty23-20020a170907c71700b00a314e96f40amr496139ejc.26.1706129958544; Wed, 24
 Jan 2024 12:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124174101.2270249-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240124174101.2270249-1-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Jan 2024 22:58:42 +0200
Message-ID: <CAHp75VcoB4fLag18FebAMHAWBJKC0zs+tcOZRUOwD8mzCrShVA@mail.gmail.com>
Subject: Re: [PATCH] spi: cs42l43: Handle error from devm_pm_runtime_enable
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:41=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> As it devm_pm_runtime_enable can fail due to memory allocations, it is
> best to handle the error.

devm_pm_runtime_enable()

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

