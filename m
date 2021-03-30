Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314C134E7E2
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhC3MuM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhC3Mtt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 08:49:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F8EC061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 05:49:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o126so23648773lfa.0
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8zPUM8r4Vka6U+t9L2xJp6XC7Qf/rJp43zNt/MIL5o=;
        b=cFlstZ/2XmcQXkJtYHZYfLXeqSCZ1MZoBF5XZZOPVNzzAvjusrDU3hMEkxdLoMo0SF
         wNKihJ5nwbt2b3NIsIDbnCKSnhzqU4ktfH9yxDDnqYEolQClB6u5GKqhxB/AHYh5Jh1m
         MNY43q7COd+eK9fTgS2no1b7qrjirUL/dqGkV8MUZhn9SM+teOtD45Izg22l8gXV/IqU
         vQYg/0XITptZr82CuwyYTEGN54UYF5DYucjhMP9/gRM956jrr2jpQcxEiC25vcpnfd7e
         qVwF3jDla5QHto7xQ3WV/Vgj/T0AKnr8DEUtUw7PiipDCAOoGadBqiLkCxRvqzomCuB2
         zBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8zPUM8r4Vka6U+t9L2xJp6XC7Qf/rJp43zNt/MIL5o=;
        b=ebFhvDMD0dgIVnXAczbivsV2XtCs7lyhSBabz1wMepsO5ZI8j61hz0sUQZzwSIblJ3
         kJpFdxARobZElCBkxAFtJKoVpUxSCueG0wy6UcpgAADIAD/Xi2H3yqAZ8zx/Ktw+dpqU
         eEuAXF4hGTdfAdg4hyPxr7ea9u+anOg2AmVaLiGOqzjKPC/HAY13eFFjove1YTxJ4Ys8
         dG1lw3TCrFUSWK32Go8Z+N5l3HLWhzuWwFldacWG0QAZneSaMQ6T7TpoJWRlahs9OQVP
         p+3a1uYUgPdDkSNJIrY5PYL8Cko4K04gxMh/v6YAFQHGLZb+WcGKcOkXKWOYR300ianJ
         UcJA==
X-Gm-Message-State: AOAM533bWnHUmF7AI32NDgxSqymwZth2Cyd+2AIArxeGrZyO2eZhf/G/
        KNphixWFxQJMYCkMEwKPCl4DRrlpknBZGxwR6nZMz+rl
X-Google-Smtp-Source: ABdhPJybcN4Fo5O1C6L7TGFx2Kz7mntwsRfku4oP7H6skeLDLIPKiYyifPoPS3uH2DWCwdW8f3QzKKhm1M+C/pMBups=
X-Received: by 2002:a19:f614:: with SMTP id x20mr19494449lfe.229.1617108587769;
 Tue, 30 Mar 2021 05:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <1617107474-46079-1-git-send-email-tiantao6@hisilicon.com>
 <CAOMZO5A8r8LuV_GOvi3=rdABFgWuC3ho=h2B4FwWB_Y-WCXUTg@mail.gmail.com> <37cc380a-4df3-44b9-9d93-903a80617f77@huawei.com>
In-Reply-To: <37cc380a-4df3-44b9-9d93-903a80617f77@huawei.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Mar 2021 09:49:36 -0300
Message-ID: <CAOMZO5C8BinwMDPSxL93UAMtXdw0VAFmpngGa6LhTZ3D44_r1Q@mail.gmail.com>
Subject: Re: [PATCH v2] spi: davinci: Use of_device_get_match_data() helper
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 30, 2021 at 9:48 AM tiantao (H) <tiantao6@huawei.com> wrote:

> What about doing it like this?

Yes, this is what I suggested before :-)
