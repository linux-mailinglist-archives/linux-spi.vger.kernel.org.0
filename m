Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140361F849F
	for <lists+linux-spi@lfdr.de>; Sat, 13 Jun 2020 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgFMSiy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Jun 2020 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgFMSix (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 Jun 2020 14:38:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399D7C03E96F
        for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2020 11:38:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i3so10116117ljg.3
        for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2020 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUjg4UzFJTjKMYMDonK0uqRDyokwZ83hjUbKbCS6MvM=;
        b=X0bRnhuTFsJNHTZsiWKCe+u5nRA5aUE10yyrcTxIgJz02jC3dNsXPP4T6a6VhQxjDQ
         MMbIh4o5+Y1XPb8TU86SFMkChqjZAoEetfsfy5DMo4tXGNZq3Qzo6JBG2Yd4t7jXr4OK
         wQrObTl7MxeX/TcY+BlMstecIRjPEUeoAUKZ0gGmcFiXl+puGHvLXIKs5NLomj3Q8lWK
         wzzUsx0Dbta9j9Hd010oiDvwlwlXrv1axIW7Lt8u4t9S0y+ISb4RyneJySP2QhT2/mLz
         a+6G69JsMoBUWRjV6S5HirRfIN65Rdelkzwta4smeTV1zcAh4EL6cIeedmBDaK76lh0q
         W7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jUjg4UzFJTjKMYMDonK0uqRDyokwZ83hjUbKbCS6MvM=;
        b=oxGfipiFiCt3QX1RXOWofgLGl2w91f4M79towl2qcQ3SJH+usdenO9Z7cB4kgU4Z+g
         QcReHusNE1SHK4WzzBtb6JGYt3kqE4zh2ylgxX74S1NwDr/u+nGKsq3HgOcacYmBwDm2
         hCAh1AqA9rrIGT8rY2TGV5NI6Tb3WtI79E4LchzrQMS8UB4SXsJiW3ntjHOpnOMIEwaY
         bX0Dwtviz/A6v6n91Eu389m49DLjpJZZgqXwYoOyjYGwEljySpAXaiXbBIn78FgkVnOB
         06hBRSHVUKvGBBmh4EIpJwPhfFjRy7osrVhT5dKJ1BDYCqTeCtV5UaA2axWXyCUVzJel
         U97Q==
X-Gm-Message-State: AOAM5322ys0liaMPcGVHqCx1jFwoLmO0mFHcLJyfUGkxdpsQDaW4bk6Y
        /5Bc9kQTSdkqSc9H6vvmXHvYVCzx/8M=
X-Google-Smtp-Source: ABdhPJwyvGPu0ql9yGhsFhBF9XXSnz0fA7HYx6BhY1QnLtUkukg40cKAA8XhqJCFBysgfbjFvdWsjA==
X-Received: by 2002:a2e:7e0c:: with SMTP id z12mr4866946ljc.146.1592073530692;
        Sat, 13 Jun 2020 11:38:50 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:2e2:84d1:c335:1451:e577:e115])
        by smtp.gmail.com with ESMTPSA id z13sm3225288lfd.7.2020.06.13.11.38.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2020 11:38:50 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Add Renesas RPC-IF support
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org
References: <721e5306-6dc5-4a3a-2bbb-459be6261357@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <ef5b6f3d-bf7c-b36c-5b6a-c202267a2087@cogentembedded.com>
Date:   Sat, 13 Jun 2020 21:38:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <721e5306-6dc5-4a3a-2bbb-459be6261357@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Should read v4, not v3 in the subject. Sigh...
