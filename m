Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4238B2C335
	for <lists+linux-spi@lfdr.de>; Tue, 28 May 2019 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfE1J3A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 May 2019 05:29:00 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50379 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfE1J3A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 May 2019 05:29:00 -0400
Received: by mail-it1-f194.google.com with SMTP id a186so3177551itg.0;
        Tue, 28 May 2019 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJcJ3bcJJJancxCaIciCXQM9EeEtO5kiGdHevOdHysw=;
        b=q29t0knwEtXdZIuvXWO8mODf3nXDlFvFOOi7wPJlxL1L0GZKz+t6FwWfTP/d2o7/Kz
         wSR6AQW4prEG2mI4kCm8ySGz8K+tm9YBzjfVgWkotCXO0hooGyONuflue0l/clzVaHjl
         x5vEm52AjT0uaRD5gY0SfRLremoh894JJGyiDCGYrFKUYsol1W761bgGiHeR7fV0gXoJ
         QCzLpPzm2aet1C3gQE3jS6jcXHyjvbSXf26kCCQ1rSqKkYW0qOoaNhpIkUAthO59+YuM
         8sVxjvumEh9IvmUhMdaA7BDALaYyEx5N6HnzMigIc9jr1n+WovrfPYrcyOfNrrpIxvvV
         BH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJcJ3bcJJJancxCaIciCXQM9EeEtO5kiGdHevOdHysw=;
        b=mLDm1lwea53oNVU+Wl/QbbtVGieibdqwz4jtjZuDt3gvgH0PInR4yssdgVbfE314Ph
         WMQG9UHUoXv2dE3r7HtSRjw5QBXrRyVPGqfNs/RDIbsT/m75CeOrd01vChHT0CkMM4DS
         KOm6d/98vYrjkjYbcS++tcy6fTwB4WypG0PY0GCYhfcSh3C5uxCdMYDDU23Iq5pxuOQj
         lQB/2VfKMDjyqXUdXfdBQMmFMqQEpjENMHE2ThweJfh+XZaFqZTOSMREbI1btCnPFmIu
         txef3s66sR3sfXhn9GQ6VOaG6ip9MTteGqNhNRaPNPzJwWdKRWwgYkBKznUHI8VKIZBc
         xaEA==
X-Gm-Message-State: APjAAAX05BPhA61cnAgeyyUJiZMLs5BDAVqHQxcQzFOc5QpQwWhuQBAn
        fjfep8XdcY52oubaIa2HRfNW1UqcctPZuEZ8LwM=
X-Google-Smtp-Source: APXvYqxiyJhSNPM1yTGodhZAq8RwC7AYbe0WcqaUUUFY10m80qgHdKsHfu9wJnEyfpBRb4w3TdU4qcbgqUB/+TMLEsM=
X-Received: by 2002:a05:660c:712:: with SMTP id l18mr2421360itk.169.1559035739818;
 Tue, 28 May 2019 02:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <1558574922-16531-1-git-send-email-skomatineni@nvidia.com> <0418cbdb-1bb6-23c3-f13d-e0a70f899f3c@nvidia.com>
In-Reply-To: <0418cbdb-1bb6-23c3-f13d-e0a70f899f3c@nvidia.com>
From:   Billy Laws <blaws05@gmail.com>
Date:   Tue, 28 May 2019 10:28:48 +0100
Message-ID: <CAFUUQHP5e=oQZC29foYD+uA96r5-M4wCxKYVL_LodrWRG5kp1Q@mail.gmail.com>
Subject: Re: [PATCH V1 00/12] LP0 entry and exit support for Tegra210
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        Laxman Dewangan <ldewangan@nvidia.com>, broonie@kernel.org,
        natechancellor@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,
By the looks of this you configure wake events but the pmc driver
still only configures lp1, which is the same as linux 4 tegra 4.4+
which also doesn't support lp0, if its selected in dts it'll just
change it to LP1/SC7 (both have same code path and neither set any lp0
stuff trm says). What confuses me further is that l4t and this
ptachset both configure wake events, which I think should only work in
LP0 and not LP1 and yet neither have lp0 entry code for t210. I also
looked at ATF, whis sets the flags to wake the cpu on interrupts,
which would suggest that it only supports lp1 (in deep sleep I dont
think them flags would work). Am I missing some important detail here?
Two other things, will you be adding full lp0 in later patchets and
will they use the bpmp or not?
