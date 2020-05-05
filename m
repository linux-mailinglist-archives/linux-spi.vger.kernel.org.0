Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0037F1C4FD1
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgEEIDj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgEEIDi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 May 2020 04:03:38 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B5AC061A0F
        for <linux-spi@vger.kernel.org>; Tue,  5 May 2020 01:03:38 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id 36so100518uaf.9
        for <linux-spi@vger.kernel.org>; Tue, 05 May 2020 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8fDSDEwKh7dqKwX49R85YOSMgKhouP4ZA9QIiyivm14=;
        b=dTgtY+YbRpoasnUpne/7fkOqogfXQBpiE9o1WsA6k1GIWHbdsgBU68ouY7Plsqjdc/
         b1bGJpoEy2VJsmEwbZN4WtZjzXY3butyr32K46thPSzdLq3BSj+7at67O1q1fj96IOR9
         pbNwx0zPjmdgRAFmsKuUfHpZckcBKXq2aHb18mgsWxE9t+0O0DjpPgpg6u6u25WDpxQq
         kI3VmNoN83IGbaMuQktc3MgqAVe4vfHKcYjfy1rmgey1ogqsBQhzsLulD+TzjmqgjT0M
         scQiiCa/j04ZYHvxxrg8Ced9hWLt7gos8B2T/I9aXDdKZd9+xMD8fqueggaxzG9mjvcu
         aqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8fDSDEwKh7dqKwX49R85YOSMgKhouP4ZA9QIiyivm14=;
        b=WX9GxWQvRYBwKxNG6hlNapVgfYJXb5i1rZk95Ni2OzGgNtZkQxbs/NT/wWJt9h2JnX
         XUCCaW0A1Hfpc8mcIWPsMTnrgv+TqiumSLPqZKE5dVZ/jnYFll3+IxLgcVv88GwGWubH
         Iq3iwY+5HtgxJMcm47VbKsCQhzkoEeYvVZH2l9WgGIl3F4xYGGsdR33YLYhiT628uJej
         I0ld4tAHOj176duNHiyuedgFqgtNIUR4UB+ucdZf3r9fF0Pa2JlZJryTdgFdy1RivFz/
         5UkaIg+51tBX844BWlycxvr/DQpQtStnBmiz4X7mAzL6cQbE+v8vwE7eIrO5kPY2Wks4
         fwUw==
X-Gm-Message-State: AGi0PuY9xdlUE/fTIX6QX7FOSq3C7J/tnrVI9h6UFf5DEDzuDQJyjwYn
        jX4RbPVMIZ4BKyCGQ/nQMXSTBsBvpNyUZ8dQAnRT3R/x
X-Google-Smtp-Source: APiQypKR1Ng7+bJuBSrlTJ8yO9SiZNyL77QbIetHSS5l1G33H2s0Z/32dJ8FOQRjkw5KuaxsRyACAfgx0ymD3LhXFKI=
X-Received: by 2002:ab0:18d:: with SMTP id 13mr1336205ual.69.1588665817520;
 Tue, 05 May 2020 01:03:37 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Tue, 5 May 2020 09:03:26 +0100
Message-ID: <CABatt_wQpbtktD=bXwJCzdm_5aLeHcQrSW2pNMRergC9jZ0sMw@mail.gmail.com>
Subject: SPI driver probe problem during boot
To:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

I've just finished debugging a SPI comms problem for a TPM device on a
TI Sitara AM4372 SoC.  The SPI bus has 3 devices

1) CAN FD Controller 0 (Using native CS)
2) CAN FD Controller 1 (Using GPIO for CS)
3) TPM Device (Using GPIO for CS)

All CS are active low.

During boot the TPM would fail it's probe but if I unbind and then
rebind the driver after boot the TPM would work fine so I got the
logic analyser out to probe the SPI bus and could see that the voltage
on the MISO line was half the expected voltage whilst the TPM was
being probed and this was due to CS0 being driven low for this period
of time.  After the TPM was probed the CS0 went high.  After debugging
this I found that the OMAP SPI controller defaults internal CS lines
to active high so when the SPI master controller is initialised this
is the state of CS0 so it's driven low for inactive.  During the probe
of the SPI master controller it calls devm_spi_register_master ->
spi_register_master which calls of_register_spi_devices which will add
the devices to the SPI master controller via spi_add_device.  This
function would call device_add. Due to the way the device tree is
parsed the SPI devices above are enumerated from the highest CS to the
lowest so the TPM device is setup first.  When device_add is called it
triggers it's probe function but the SPI bus hasn't been setup yet and
hence the TPM driver tries to communicate with the TPM device whilst
CS0 is being driven low causing the CAN FD controller to also respond
reducing the voltage on the MISO line.  In spi_device_add it calls

status = spi_setup(spi);

which would setup the CS lines so I modified the
of_register_spi_devices function to make it a 2 phase operation so the
CS lines are all setup and then it iterates of the SPI devices a
second time to add them to the driver model via device_add and the TPM
now probes fine.

Here's the change I made (it won't apply I'm afraid as gmail doesn't
like pasting tabs)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 89254a5..1012933 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -545,14 +545,6 @@ int spi_add_device(struct spi_device *spi)
  goto done;
  }

- /* Device may be bound to an active driver when this returns */
- status = device_add(&spi->dev);
- if (status < 0)
- dev_err(dev, "can't add %s, status %d\n",
- dev_name(&spi->dev), status);
- else
- dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
-
 done:
  mutex_unlock(&spi_add_lock);
  return status;
@@ -614,6 +606,9 @@ struct spi_device *spi_new_device(struct spi_master *master,
  status = spi_add_device(proxy);
  if (status < 0)
  goto err_remove_props;
+ status = device_add(&proxy->dev);
+ if (status < 0)
+ goto err_remove_props;

  return proxy;

@@ -1663,12 +1658,19 @@ of_register_spi_device(struct spi_master
*master, struct device_node *nc)
  */
 static void of_register_spi_devices(struct spi_master *master)
 {
+ struct spi_device_list_elem {
+ struct spi_device *spi_dev;
+ struct list_head list;
+ };
+ struct spi_device_list_elem *spi_dev_elem;
  struct spi_device *spi;
  struct device_node *nc;
+ struct list_head spi_devices, *elem, *tmp;

  if (!master->dev.of_node)
  return;

+ INIT_LIST_HEAD(&spi_devices);
  for_each_available_child_of_node(master->dev.of_node, nc) {
  if (of_node_test_and_set_flag(nc, OF_POPULATED))
  continue;
@@ -1678,6 +1680,30 @@ static void of_register_spi_devices(struct
spi_master *master)
  nc->full_name);
  of_node_clear_flag(nc, OF_POPULATED);
  }
+ spi_dev_elem = kmalloc(sizeof(*spi_dev_elem), GFP_KERNEL);
+ if (spi_dev_elem == NULL) {
+ printk(KERN_ERR "of_register_spi_devices : failed to allocate spi
dev elem\n");
+ continue;
+ }
+ spi_dev_elem->spi_dev = spi;
+ list_add_tail(&spi_dev_elem->list, &spi_devices);
+ }
+
+ list_for_each_safe(elem, tmp, &spi_devices) {
+ int status;
+ struct spi_device *spi_dev;
+
+ spi_dev_elem = list_entry(elem, struct spi_device_list_elem, list);
+ spi_dev = spi_dev_elem->spi_dev;
+ status = device_add(&spi_dev->dev);
+ if (status < 0)
+ dev_err(&master->dev, "can't add %s, status %d\n",
+ dev_name(&spi_dev->dev), status);
+ else
+ dev_dbg(&master->dev, "registered child %s\n", dev_name(&spi_dev->dev));
+
+ list_del(elem);
+ kfree(elem);
  }
 }
 #else
@@ -1772,12 +1798,18 @@ static acpi_status
acpi_register_spi_device(struct spi_master *master,
  acpi_device_set_enumerated(adev);

  adev->power.flags.ignore_parent = true;
- if (spi_add_device(spi)) {
- adev->power.flags.ignore_parent = false;
- dev_err(&master->dev, "failed to add SPI device %s from ACPI\n",
- dev_name(&adev->dev));
- spi_dev_put(spi);
- }
+ if (spi_add_device(spi))
+ goto err_put_dev;
+ if (device_add(&proxy->dev))
+ goto err_put_dev;
+
+ return AE_OK;
+
+err_put_dev:
+ adev->power.flags.ignore_parent = false;
+ dev_err(&master->dev, "failed to add SPI device %s from ACPI\n",
+ dev_name(&adev->dev));
+ spi_dev_put(spi);

  return AE_OK;
 }

Now this is on a oldish kernel (4.12) and moving the kernel forward
isn't trivial.  I was just wondering if this has been fixed already so
I could backport it, I couldn't see anything in the latest kernel but
maybe it has been solved a different way.  If not is there a better
way of fixing this? Or is the OMAP SPI controller driver the problem,
should it parse the child nodes first and set itself up accordingly?

I'm more than happy to cleanup the hack I have put in place and submit
it if you think it's an acceptable solution.

Regards,
Martin.
