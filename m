Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F343E1DC
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJ1NRu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 09:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhJ1NRu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 09:17:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652D3C061570
        for <linux-spi@vger.kernel.org>; Thu, 28 Oct 2021 06:15:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f8so3096444edy.4
        for <linux-spi@vger.kernel.org>; Thu, 28 Oct 2021 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rt-labs-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQV64EAd+nTFpvp3R7GD4uYJxEyZtC0DTNNMhvE2vBM=;
        b=lJgwmE/0aH8HxPRpj/mOs2WSKG8JPnaW+3iYMTwSrwvz/pY0k4G0St6hpojUn5KV7b
         BNv9mb1FbRsnwmapgb5dvKnM0ENcWAL9FPV11Uw+fZlR0y2vO2mJPVFEErawX8FJILIn
         4+qy1GMb+R+OlRZYjud4BGelE5UdibkQ8vKL+S2gWNRDJ6D0P/ojKjRkVVaJkpBHm4zs
         0EHFiaiaJl+elkNe1YcWAUg4H8EJyABPtIUQC/qSYgom52C/x3TqB3ABciRCmWzg5Xu1
         ZEj/JFFPAeavA3yaQkRS4Rm8WSS2USaPM00dOXgSedyUKdOFALb1KNt9KfFeTQB8DNV0
         cuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQV64EAd+nTFpvp3R7GD4uYJxEyZtC0DTNNMhvE2vBM=;
        b=dB1uXBI/puDJR6smcP7ukx3YRv9U+iTnBZS0qT0tjKxa0bSU6VMOHmKtPHh5crsWZC
         +oCSvSnL9Pq/YKH6e+S+zFpsaAq+V8UbhZOE5vhS59wfmOBPGAP+7znVvyDTjXFq7H+M
         JxcmXizlXulKfewi7xyLwrJ5N4fBUGn+s004TpxF7yoXa3YQGNqbIyeoLG9On/OBneeG
         PKV9DywMjd0vcKEn5aQ0bA+E4D5W58LXaQtK8vzZeUb2s01H4LtTUhW69EFhSgHrlJhb
         loJXBEpijyTCcSCq7sadTnUtLt0Q+tyVw1rm/XaVoSsq/mu1jSC1700wFx9d0QJWJVJv
         NvIg==
X-Gm-Message-State: AOAM532RP9o7yHjwZUULrcnd/vZV3lYDfmhHyk1bQMAq+4FxkjmhA2aP
        884g6U2Iip4M6sF9YecQrg27oc4AXOI0Tqk8aWTBO9PpenQ1KkrYZ6E=
X-Google-Smtp-Source: ABdhPJx8Knp76CqqeWaPtpxw04szNnZveaZwW1BUngvsjD9lZneAPBCUd1nCETjU0zQugm4OZXWhWNhfnosEBYSZtlw=
X-Received: by 2002:a17:906:6403:: with SMTP id d3mr5194001ejm.37.1635426921721;
 Thu, 28 Oct 2021 06:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211028130500.6727-1-joakim.plate@rt-labs.com>
In-Reply-To: <20211028130500.6727-1-joakim.plate@rt-labs.com>
From:   Joakim Plate <joakim.plate@rt-labs.com>
Date:   Thu, 28 Oct 2021 15:15:11 +0200
Message-ID: <CA+ZeBh-FBBQc6+2w70+9D8S23ApffXitoauQkwc+8RVqu6Q9ww@mail.gmail.com>
Subject: Re: [PATCH] spi: imx: Respect delay_us
To:     linux-spi@vger.kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Should be added here, that this patch was adapted from a verified
patch that was running on an older kernel revision:
https://github.com/varigit/linux-imx
f0e3c7acf46097fdd1fd9fd3279c26faf8226b4e and was adapted to upstream
master. I've not verified it on master, but I still wanted to get the
patch published.

/Joakim

Ps. Resend as unformatted text.
