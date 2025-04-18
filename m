Return-Path: <linux-spi+bounces-7678-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC125A93B34
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 18:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E16F17A8B44
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F65215792;
	Fri, 18 Apr 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XcbhjcJC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1851DC992
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994728; cv=none; b=syuxYsoF9pfv4yOVh4LKTJQfEmjQC6h85tRHdNd9ikSJyDSvrfZEtd0bumsPV0JXmIUDyN/OapbiitwaLOPL8iBio2Rv1NHWblgg5wmLAy7vUYEoNgE+g9NatAK6m0u4IdDXH0XkyP/M1vPGEx2n0hQWIVbx5kP7FSdGZBxxiTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994728; c=relaxed/simple;
	bh=Uo4qWoaPJqLSHj0LVQHUBiENxwtfpIYD2d0ih9fPzv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/zTQpN7zMTY3Y6y0JkOReQ0qSjM6NIdIliz9aomILu2SsdfhDwY2Sb6eyuWX1H6ZK3iJpj0Ocxe7yYviIa4gn9ah5UsGIuOePPAXWVl9iYfj6YwK4kpbcJS5LlE26YRi6jmoq78lAejp/Cpc2se2dA1OlNTxV+wLRD0uwNxtKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XcbhjcJC; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601b6146b9cso959807eaf.0
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744994725; x=1745599525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6NzstuCAOmmHk9gufPNMowPg4ZJqKGQeUURUENblfU=;
        b=XcbhjcJCJUL+nG9nMbUxZhI4jQ/KGmyQkTYMis39h2G79xCmSIcsW8JAN3LJ1emJBt
         Vu1qB/o3EHJ7Qyru++GvqqsYvvUVChrdv5YLZLfzHwssiGjebwlTiSVsFdeNNAQR+YuX
         B83PqJHy90q69JHRzhAzryxYanoDgK08K1m4INfZVU0fozckiJE5qtiaxWKmwVYx/JEV
         JbLuGH8QsNemdCXYG4U9PTq+Ghk5Qi9FiFTJvTpWBqdI8sSeQR0HOyv5PvZ2MFAjlG9M
         QWr71yZce9vESxU3jw5wS7LSp7XBKD4La+Hs+G4665zAQhSesctCBonga0BOEjs14OQv
         BzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744994725; x=1745599525;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6NzstuCAOmmHk9gufPNMowPg4ZJqKGQeUURUENblfU=;
        b=fu1lqOqVI0h8JGH1eaz4m6QfdlybX07f/w876TI+ipMPRLxr9l9fixec20LA621lnd
         20VUHNxGgbJyO9uMS1PzsZ9nsUeQmB4X49HKlLBLSoKnpqQsepl+Hb35Yr7+VP2Peqrk
         JVb5CZgPIDmEmoi3zdw54jc9gANPt0D66oszjSKUwjZPmSZHnrolqQ/V8+XnNOpNKuor
         zPziDHOu8sJE7NISPfRY9UymEpgQ7rdUHoTEoiDTQ9xGfrEy364zMh/m2oj9mvaWANY5
         hxorYdYWZnBiUPIeXI7IzFqgsqIVlOEiUq9Sjkk5/8J2pl2q1h8RKS93KkxrPJ76C67c
         wMYg==
X-Forwarded-Encrypted: i=1; AJvYcCVYBqvD46+XB96lraNmr2g+g7dqYiFaOx/G807gm8OZLWM+fs4g6y09FJnEUlQkDkGMFhL8EtwJtAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAee6D1+JVNVtXo3k0TGrU9IcqpendRtY2BiUFC/q6P+LFPo+
	Zl+fIlDNgCHO/UEO1D2L1hR4K1fw1NI8l6NjVncGgKAEauFl4oLT1pP18tn11uM=
X-Gm-Gg: ASbGncsahA2Sn5JmtylfE9iQcqazQK9CEwBBmyP1siM5ntMxhiA9UnBcJKN6dtEpovt
	Xxe7nZ3atfywgCRN1Q1ImZCsZHY0WQE8E50Q2NcCyUlsrqAADgksrzo8LsYRS9vK1ogn9+9oTFU
	4KXAhRjBGgfleDM39cPJsrxbZXuYIyCCVQTQg/gKXry+N86SRDw9SEwii1KMl6eq4FMDeueDKS7
	GlYP1ojZZHwM1NX25cFhh5MN0bXkSo7RKuyaH9ZdqjU2lcpw6BEHY6fhSwFHtgaaIEMOmuipN+t
	ktIjb2C+E2hr9OM59ztagjoZDNyj18R1S4RccSoF+uYINcW4iFHNCDrDIYpFETEl86NCqGoG5bf
	3C/VjDsQ06KnA7i30DA==
X-Google-Smtp-Source: AGHT+IHlrWEvPvcpyQH3vfEagV8y+fG9NzkNtLJpHiwahEvDHTBbsyJNEUPJDmzVUONvuzHkoQoeCw==
X-Received: by 2002:a4a:e911:0:b0:603:f526:5e76 with SMTP id 006d021491bc7-6060055bb2emr2042535eaf.6.1744994724882;
        Fri, 18 Apr 2025 09:45:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279? ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff69cbb2sm429485eaf.27.2025.04.18.09.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 09:45:23 -0700 (PDT)
Message-ID: <c6177e8a-f024-452e-80d4-a801410ce05e@baylibre.com>
Date: Fri, 18 Apr 2025 11:45:21 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: offload: check ops and match pointers before use
To: Andres Urian <andres.emb.sys@gmail.com>
Cc: broonie@kernel.org, skhan@linuxfoundation.org, linux-spi@vger.kernel.org
References: <20250417232319.384094-1-andres.emb.sys@gmail.com>
 <6d6b5ea4-0f08-4618-9fe2-d681cd2f51ea@baylibre.com>
 <CAMihqu_GcW9PuXdacfNSop8MByh1O6RkczAO7WphFpCAxcm8Tg@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAMihqu_GcW9PuXdacfNSop8MByh1O6RkczAO7WphFpCAxcm8Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 11:37 AM, Andres Urian wrote:


> Hi David.
> 
> Thanks for your comments! I did not see the full picture and now it is
> clear to me that it is not required to check the trigger->ops in
> spi_offload_trigger_get().
> 
> Then I will create another patch to remove the trigger->ops check that you
> mentioned in spi_offload_trigger_get, and make match a required callback
> in devm_spi_offload_trigger_register() instead.

To save some future review, I would consider these two separate changes and put
them in two separate patches.

