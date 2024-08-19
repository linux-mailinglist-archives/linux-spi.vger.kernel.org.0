Return-Path: <linux-spi+bounces-4214-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086689564E8
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 09:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A42281637
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113D014B959;
	Mon, 19 Aug 2024 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzh6NT0e"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858814F12F;
	Mon, 19 Aug 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053657; cv=none; b=Ldbn8rOTBpc5tuDxJgKa8rRBrijQDJv5ERwu4O/lBqbHYEeOLxG8fe9jD91N8ey5/xfB7dRuR2bMgSFD2tlRR6p80xDMdyzaZzyhSFmHOKB9nmOjQ7rW/ukEhXmb1gT2dKb7fK6SSlszmk0FJ7XAUWi61UDJe3A0Rh6XAjK9WW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053657; c=relaxed/simple;
	bh=qyje/1d6y10S8mco5xhZc908dVVxhPOIWTk6J6jlvEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RM1Z3EZx5TeiaD8pOGmNeC4/MHiIqFFYFUWjcWWMPYAPnG/0DbfxyBD7r3cVM40nFYD+HSfwzd9NCkVPakNGB96Amka0dzL1cuMD/6rh7PzadxkSGQEdXz6O37dj9IzQoca/h6LaKpdPlnIXPBVHc0/vuNj1WRYR1VykUYHC2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hzh6NT0e; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b41af35b1fso16869377b3.0;
        Mon, 19 Aug 2024 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724053655; x=1724658455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qyje/1d6y10S8mco5xhZc908dVVxhPOIWTk6J6jlvEw=;
        b=Hzh6NT0eyW8K7JR2Thb/93cOlYYn5WoQ5ocQBHcK/3advlRnZ6zeSAs0raMJlEkqD4
         kzkAkRxQYBGDi1NoAY06Mmh7d5PglKb5GFDIJgP2TRa+JtEGq+Z9dJMzw+MnljUT5nD9
         0Ik5TQJH/MVlhKFpMBd4cbXjW+LCByqY4A5SOkj0Ai1aGZerZi5Wb9ys31Q5kSDoYWD2
         N/TN724V54DUoUihHGyYtfVU160LorY1hmidA4A9344tYBsbicYoa6jDUAtppSjtwVTS
         0yF1q8w7SQBFzryqqLmDmktPxu99TXNuMdpN76U2oDSwJAhgLdeJaebPYz7iMg7DN3IH
         qUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053655; x=1724658455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyje/1d6y10S8mco5xhZc908dVVxhPOIWTk6J6jlvEw=;
        b=gMpYIx3huMvhn0VYlvohv7ZQXzMmAqpxgodOXDIVli2dpQG8v/8yf2wtVnW24lRuEt
         teGE8AdOUkm3K3I/sAvHB4vGZWmN42N3UiOUnykA5ev4FTf2fGWfTimM7eSkdIAlkKNI
         fnk+Fhs7GoWAvWwocF2BCdcZYhsU/2FsIXgQQh1YxdtfDoZW85IyG05Gq7nReaBN4r+o
         +IT9PpvJGrES2Fj1I08t9PajilHLzEAog2MaG6oDzrOQmX46+KMSYShjj2hf/yZoFeKO
         KMzCekAUTNtumdkOMCfs1kDRgRNyVXGlzIYIxKz5IdrT+qcvkILVXmPuwV9luMW6pvzz
         MWkg==
X-Forwarded-Encrypted: i=1; AJvYcCVowqyP7xl7w4AHB94tOm7hNUY2aU+TUVzM1/NhpU0husGZvgjw6Zrda+KHdl6jIDWK0zNRIJLcsLdX5Fls7QWQbDbqbv2bvIvYWrDTnHrMEBdMdkKgdTT5npvRjdk0Zeb3KJSaleV4
X-Gm-Message-State: AOJu0Yzdb/nSeit/9pJQq6GSTje6sjVDevTWqFGPvVqTAzvewpxwUAvs
	FlxOM5Eu1CIBMEac1+FN3cCQFyTLSFYmWxwnj6QE3rpCpuY0dii/wJDsra2IQFARqt4fHgfJwgK
	ZiH1E4FGnxGsUlOXTFCrH804fHyU=
X-Google-Smtp-Source: AGHT+IETb0QGWnSUGr2FJKioZNvaClONWNrm2AIRQlEuq9idRm6Z23pD4nNHxm7+gM9N9YMu/xvEiOE9EKYTFrMuOIc=
X-Received: by 2002:a05:690c:4e85:b0:6b0:3303:803b with SMTP id
 00721157ae682-6b4509bb843mr59369587b3.23.1724053655411; Mon, 19 Aug 2024
 00:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819040709.2801490-1-ruanjinjie@huawei.com>
In-Reply-To: <20240819040709.2801490-1-ruanjinjie@huawei.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 19 Aug 2024 09:47:24 +0200
Message-ID: <CAOiHx=kutdcmATMQNsp+aYvAm7g2u+GDRfdg6Oe1fcE7XNRbTA@mail.gmail.com>
Subject: Re: [PATCH -next] spi: bcm63xx: Fix module autoloading
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 19 Aug 2024 at 05:59, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.

Your code change adds a MODULE_DEVICE_TABLE() to platform_device_id,
not of_device_id (which is also missing it). Please align change and
message.

Also since this is a fix, please add an appropriate Fixes tag and Cc stable.

>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Apart from that the change looks good.

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

Best Regards,
Jonas

